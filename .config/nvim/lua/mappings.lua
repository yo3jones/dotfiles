local cmd = vim.cmd

-- avoid mistyping write/quit
cmd('command WQ wq')
cmd('command Wq wq')
cmd('command W w')
cmd('command Q q')

-- set leader to <Space>
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {})

function ToggleRelativeNumbers()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

function ToggleCursorColumn()
    vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
end

function ToggleFastMode()
    ToggleRelativeNumbers()
    ToggleCursorColumn()
end

vim.cmd([[
  command! -nargs=0 ToggleRelativeNumbers lua ToggleRelativeNumbers()
  command! -nargs=0 ToggleCursorColumn lua ToggleCursorColumn()
  command! -nargs=0 ToggleFastMode lua ToggleFastMode()
]])
-- command! -nargs=1 SaveSessionName lua saveSession('<args>')

vim.api.nvim_set_keymap('n', '<leader><leader>', ':ToggleFastMode<cr>',
                        {noremap = true, silent = true})

-- function saveSession(name)
--   local auto_session = require('auto-session')
--   local sessions_dir = auto_session.conf.auto_session_root_dir .. name
--   auto_session.SaveSession(sessions_dir)
-- end
