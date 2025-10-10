-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

-- vim.api.nvim_set_keymap("n", "<C-h>", ":TmuxNavigateLeft<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-j>", ":TmuxNavigateDown<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-k>", ":TmuxNavigateUp<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true })

-- Insert Timestamp
vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  'i<C-R>=strftime("%A %d/%m/%Y %I:%M%p")<CR><Esc>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-r>t",
  '<C-R>=strftime("%A %d/%m/%Y %I:%M%p")<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>T",
  'i<C-R>=strftime("%Y-%m-%dT%H:%M")<CR><Esc>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-r>T",
  '<C-R>=strftime("%Y-%m-%dT%H:%M")<CR>',
  { noremap = true, silent = true }
)
