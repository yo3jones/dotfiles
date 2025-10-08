-- (c) Meta Platforms, Inc. and affiliates. Confidential and proprietary.

-- @lint-ignore-every LUA_LUAJIT

-- This imports /usr/share/fb-editor-support/nvim/lua/meta/init.lua
local meta = require("meta")

-- Keybinds
vim.api.nvim_set_keymap(
  "n",
  "<leader>p",
  [[<cmd>Telescope myles<CR>]],
  { noremap = true, silent = true }
)

-- Local LSP Configs
-- This imports ~/.config/nvim/lua/lsp.lua or ~/.config/nvim/lua/lsp/init.lua.
local lsp_util = require("lsp")
-- This imports `lua/lspconfig/init.lua` from the nvim-lspconfig plugin.
local nvim_lsp = require("lspconfig")

-- Setup language server clients from the neovim@meta plugin.
-- These will only autostart on the corresponding filetypes, iow you don't need
-- to gate these behind a filetype check.
local servers = {
  "rusty@meta",
  "pyls@meta",
  "wasabi@meta",
  "pyre@meta",
  "thriftlsp@meta",
  "cppls@meta",
  "buckls@meta",
  "erlang@meta",
  "gopls@meta",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = lsp_util.on_attach,
    capabilities = lsp_util.capabilities,
    print_meta_ls_statuses_to_messages = false,
  })
end

-- Start a language server client from a native lspconfig config.
nvim_lsp["flow"].setup({
  cmd = { "flow", "lsp" },
  on_attach = lsp_util.on_attach,
  capabilities = lsp_util.capabilities,
})

nvim_lsp["hhvm"].setup({
  on_attach = lsp_util.on_attach,
  capabilities = lsp_util.capabilities,
})

-- null-ls configs
-- This imports `lua/null-ls/init.lua` from the null-ls plugin.
local null_ls = require("null-ls")
-- Register allows you to add more null-ls sources after having already called
-- null_ls.setup().
null_ls.register({
  meta.null_ls.diagnostics.arclint,
  meta.null_ls.formatting.arclint,
})

-- Treesitter configs
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.install").command_extra_args = {
    curl = { "--proxy", "http://fwdproxy:8080" },
}
