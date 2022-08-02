local lsp_util = require("lsp")
local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

nvim_lsp.gopls.setup({
  on_attach = function(client, bufnr)
    lsp_util.on_attach(client, bufnr)
    vim.api.nvim_buf_set_keymap(
      bufnr, 
      "n", 
      "<space>f", 
      "<cmd>lua goFormat()<CR>", 
      { noremap = true, silent = true }
    )
  end,
  capabilities = lsp_util.capabilities,
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
  capabilities = lsp_util.capabilities,
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

-- trim white space
vim.cmd [[ autocmd BufWritePre * %s/\s\+$//e ]]
