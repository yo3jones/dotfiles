local cmd = vim.cmd

-- avoid mistyping write/quit
cmd("command WQ wq")
cmd("command Wq wq")
cmd("command W w")
cmd("command Q q")

-- set leader to <Space>
vim.api.nvim_set_keymap(
  "",
  "<Space>",
  "<Nop>",
  { noremap = true, silent = true }
)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

function toggleRelativeNumbers() 
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

function toggleCursorColumn() 
  vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
end

function toggleFastMode()
  toggleRelativeNumbers()
  toggleCursorColumn()
end

vim.cmd([[
  command! -nargs=0 ToggleRelativeNumbers lua toggleRelativeNumbers()
  command! -nargs=0 ToggleCursorColumn lua toggleCursorColumn()
  command! -nargs=0 ToggleFastMode lua toggleFastMode()
]])

vim.api.nvim_set_keymap(
  "n",
  "<leader><leader>",
  ":ToggleFastMode<cr>",
  { noremap = true, silent = true }
)
