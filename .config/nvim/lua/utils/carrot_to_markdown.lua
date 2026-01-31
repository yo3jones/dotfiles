local M = {}

local getCurrentCodeFenceRange = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local lang_tree = vim.treesitter.get_parser(bufnr, "markdown")
  if not lang_tree then
    print("Treesitter parser for markdown not found.")
    return
  end
  local tree = lang_tree:parse()[1]
  local root = tree:root()
  local query = vim.treesitter.query.parse(
    "markdown",
    "((fenced_code_block) @code_fence_content)"
  )

  local _, node = query:iter_captures(root, bufnr, line, -1)()
  return node:range()
end

local getOutputCodeFenceRange = function()
  local _, _, lua_end_row = getCurrentCodeFenceRange()

  local bufnr = vim.api.nvim_get_current_buf()
  local lang_tree = vim.treesitter.get_parser(bufnr, "markdown")
  if not lang_tree then
    print("Treesitter parser for markdown not found.")
    return
  end
  local tree = lang_tree:parse()[1]
  local root = tree:root()
  local query = vim.treesitter.query.parse(
    "markdown",
    "((fenced_code_block) @code_fence_content)"
  )
  local _, node = query:iter_captures(root, bufnr, lua_end_row, -1)()

  return node:range()
end

local replaceOutputFence = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_line, _, end_line = getOutputCodeFenceRange()

  if start_line == nil or end_line == nil then
    vim.notify("No Output Code Fence Found")
    return
  end

  vim.notify(vim.inspect({ start = start_line - 1, ["end"] = start_line }))

  vim.api.nvim_buf_set_lines(
    bufnr,
    start_line,
    start_line + 1,
    false,
    { "<!-- Output Start -->" }
  )

  vim.api.nvim_buf_set_lines(
    bufnr,
    end_line - 1,
    end_line,
    false,
    { "<!-- Output End -->" }
  )
end

M.executeAndOutputMarkdown = function()
  -- TODO: find comment blocks and delete between

  vim.notify("before execute")
  require("carrot").execute_normal()
  vim.notify("after execute")

  -- TODO: how do we know when to do our replacement???
  vim.defer_fn(replaceOutputFence, 1000)
end

return M
