-- Replace the URL of a markdown link with an fburl.com short link.
--
-- Shortening is done by shelling out to the `meta` CLI, which is present on
-- every Meta dev environment (the standalone `fburl` binary is not).

local M = {}

local defaults = {
  -- Argv used to create a short link. The URL is appended as `--url=<url>`.
  cmd = { "meta", "fburl.link", "create", "--output=json" },
  -- Milliseconds to wait for the CLI before giving up.
  timeout = 30000,
  -- Lua patterns for hosts that are already short. Matching URLs are skipped.
  short_hosts = { "fburl%.com", "fb%.me" },
  -- Ask before creating more than one link at a time. FBUrls are only
  -- supposed to be created by explicit user action, so a range that would
  -- silently mint a dozen of them is worth a prompt.
  confirm_multiple = true,
}

M.opts = vim.deepcopy(defaults)

function M.setup(opts)
  M.opts = vim.tbl_extend("force", vim.deepcopy(defaults), opts or {})
end

local function trim(s)
  return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function plural(n)
  return n == 1 and "" or "s"
end

local function is_short(url)
  for _, host in ipairs(M.opts.short_hosts) do
    if
      url:match("^https?://" .. host .. "[/?#]")
      or url:match("^" .. host .. "[/?#]")
    then
      return true
    end
  end
  return false
end

---Every inline markdown link on `line`, as 1-based inclusive byte ranges.
---`s`/`e` span the whole `[text](url)`, `url_s`/`url_e` span just the URL.
local function inline_links(line)
  local found = {}
  local init = 1
  while true do
    -- `()` is a position capture: `ts` is where the target starts.
    local s, e, ts, target = line:find("%[[^%]]*%]%(()([^%)]*)%)", init)
    if not s then
      break
    end
    init = e + 1

    -- Split `url "optional title"` and unwrap `<url>`.
    local lead, url = target:match("^(%s*)(%S*)")
    local url_s = ts + #lead
    if url:match("^<.*>$") then
      url, url_s = url:sub(2, -2), url_s + 1
    end

    if url ~= "" then
      table.insert(found, {
        s = s,
        e = e,
        url = url,
        url_s = url_s,
        url_e = url_s + #url - 1,
      })
    end
  end
  return found
end

---Bare URLs on `line` that are not already part of an inline link.
local function bare_urls(line, links)
  local found = {}
  local init = 1
  while true do
    local s, e = line:find("https?://[^%s<>%)%]\"']+", init)
    if not s then
      break
    end
    init = e + 1

    local covered = false
    for _, link in ipairs(links) do
      if s >= link.s and e <= link.e then
        covered = true
        break
      end
    end

    if not covered then
      table.insert(found, {
        s = s,
        e = e,
        url = line:sub(s, e),
        url_s = s,
        url_e = e,
      })
    end
  end
  return found
end

local function targets_in_line(line, row)
  local links = inline_links(line)
  local targets = vim.list_extend(links, bare_urls(line, links))
  for _, t in ipairs(targets) do
    t.row = row
  end
  table.sort(targets, function(a, b)
    return a.s < b.s
  end)
  return targets
end

local function get_line(bufnr, row)
  return vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
end

---The link under the cursor, falling back to the first one on the line.
local function target_at_cursor(bufnr)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local targets = targets_in_line(get_line(bufnr, row) or "", row)
  for _, t in ipairs(targets) do
    if col + 1 >= t.s and col + 1 <= t.e then
      return t
    end
  end
  return targets[1]
end

local function targets_in_range(bufnr, line1, line2)
  local targets = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, line1 - 1, line2, false)
  for i, line in ipairs(lines) do
    vim.list_extend(targets, targets_in_line(line, line1 + i - 1))
  end
  return targets
end

---Create a short link for `url`, calling `cb(short_url, err)` on the main loop.
local function create(url, cb)
  local cmd = vim.list_extend(vim.deepcopy(M.opts.cmd), { "--url=" .. url })
  local on_exit = vim.schedule_wrap(function(res)
    if res.code ~= 0 then
      local err = trim(res.stderr)
      local msg = err ~= "" and err or trim(res.stdout)
      return cb(nil, msg ~= "" and msg or ("exited with " .. res.code))
    end
    local ok, decoded = pcall(vim.json.decode, res.stdout)
    if
      not ok
      or type(decoded) ~= "table"
      or type(decoded.short_url) ~= "string"
    then
      return cb(nil, "unexpected output: " .. trim(res.stdout))
    end
    cb(decoded.short_url)
  end)

  local opts = { text = true, timeout = M.opts.timeout }
  local ok, err = pcall(vim.system, cmd, opts, on_exit)
  if not ok then
    vim.schedule(function()
      cb(nil, tostring(err))
    end)
  end
end

---Write the short links back, newest position first so earlier edits on the
---same line keep their byte offsets.
local function apply(bufnr, edits, failures, skipped)
  table.sort(edits, function(a, b)
    if a.row ~= b.row then
      return a.row > b.row
    end
    return a.url_s > b.url_s
  end)

  local applied = 0
  for _, ed in ipairs(edits) do
    local line = vim.api.nvim_buf_is_valid(bufnr) and get_line(bufnr, ed.row)
    if line and line:sub(ed.url_s, ed.url_e) == ed.url then
      vim.api.nvim_buf_set_text(
        bufnr,
        ed.row - 1,
        ed.url_s - 1,
        ed.row - 1,
        ed.url_e,
        { ed.short }
      )
      applied = applied + 1
    else
      local msg = "line %d changed while shortening"
      table.insert(failures, msg:format(ed.row))
    end
  end

  if #failures > 0 then
    vim.notify(
      "fburl: " .. table.concat(failures, "\n"),
      applied > 0 and vim.log.levels.WARN or vim.log.levels.ERROR
    )
  end
  if applied > 0 then
    local msg =
      ("fburl: shortened %d link%s"):format(applied, plural(applied))
    if skipped > 0 then
      msg = msg .. (", skipped %d already short"):format(skipped)
    end
    vim.notify(msg)
  end
end

---@param o? { range?: integer[] } defaults to the link under the cursor
function M.shorten(o)
  o = o or {}
  local bufnr = vim.api.nvim_get_current_buf()

  local targets
  if o.range then
    targets = targets_in_range(bufnr, o.range[1], o.range[2])
  else
    local t = target_at_cursor(bufnr)
    targets = t and { t } or {}
  end

  local todo, skipped = {}, 0
  for _, t in ipairs(targets) do
    if is_short(t.url) then
      skipped = skipped + 1
    else
      table.insert(todo, t)
    end
  end

  if #todo == 0 then
    local msg = skipped > 0 and "fburl: already shortened"
      or "fburl: no link found"
    return vim.notify(msg, vim.log.levels.WARN)
  end

  if #todo > 1 and M.opts.confirm_multiple then
    local prompt = ("Create %d fburl short links?"):format(#todo)
    if vim.fn.confirm(prompt, "&Yes\n&No", 2) ~= 1 then
      return
    end
  end

  vim.notify(("fburl: shortening %d link%s…"):format(#todo, plural(#todo)))

  local edits, failures, pending = {}, {}, #todo
  for _, t in ipairs(todo) do
    create(t.url, function(short, err)
      if short then
        table.insert(edits, vim.tbl_extend("force", t, { short = short }))
      else
        table.insert(failures, ("%s: %s"):format(t.url, err))
      end
      pending = pending - 1
      if pending == 0 then
        apply(bufnr, edits, failures, skipped)
      end
    end)
  end
end

return M
