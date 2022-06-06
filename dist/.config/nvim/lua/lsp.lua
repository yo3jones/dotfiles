local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspconfig settings

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap(
    "n",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>D",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    opts
  )
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>ca",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    opts
  )
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>e",
    "<cmd>lua vim.diagnostic.open_float()<CR>",
    opts
  )
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap(
    "n",
    "<space>q",
    "<cmd>lua vim.diagnostic.setloclist()<CR>",
    opts
  )
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  vim.diagnostic.config({
    underline = true,
    float = true,
    virtual_text = {
      source = "always",
      format = function(diagnostic)
        local new_line_location = diagnostic.message:find("\n")

        if new_line_location ~= nil then
          return diagnostic.message:sub(1, new_line_location)
        else
          return diagnostic.message
        end
      end,
    },
  })
end

-- null-ls configs
-- local null_ls = require("null-ls")
-- null_ls.setup({
--   on_attach = on_attach,
--   sources = {
--     null_ls.builtins.formatting.trim_whitespace,
--     null_ls.builtins.formatting.trim_newlines,
--   },
-- })

local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

nvim_lsp.gopls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(
      bufnr, 
      "n", 
      "<space>f", 
      "<cmd>lua goFormat()<CR>", 
      { noremap = true, silent = true }
    )
  end,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl" },
  root_dir = util.root_pattern("go.mod", ".git"),
  single_file_support = true,
  settings = {
    gopls = {
      gofumpt = true,
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    }
  },
  init_options = {
    usePlaceholders = true,
  }
})

nvim_lsp.golangci_lint_ls.setup({
  capabilities = capabilities,
})

local Job = require("plenary.job")
function goFormat()
  local old_lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local data = {}
  local errored = false
  local fmt_job = Job:new({
    command = "gofumpt",
    args = { "-extra" },
    writer = old_lines,
    on_exit = function(_, return_val)
      if return_val ~= 0 then
        errored = true
      end
    end,
  })
  Job:new({
    command = "golines",
    args = { "--max-len=80", "--chain-split-dots" },
    writer = fmt_job,
    on_stdout = function(_, d, _)
      table.insert(data, d)
    end,
    on_exit = function(_, return_val)
      if return_val ~= 0 then
        errored = true
      end
    end,
  }):sync()

  if errored == false then
    -- TODO check if there are any changes first
    vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
  end
end

-- vim.cmd([[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 100)]])
vim.cmd([[autocmd BufWritePre *.go lua goFormat()]])

-- local servers = {
--   "gopls", -- go install golang.org/x/tools/gopls@latest
-- }
--
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--   })
-- end
