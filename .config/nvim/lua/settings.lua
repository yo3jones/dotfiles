vim.opt.termguicolors = true

-- General Stuff
vim.opt.compatible = false
-- filetype plugin on
-- set directory=$HOME/.vim/swap_files/
vim.opt.spell = false
vim.opt.spelllang = "en_us"
-- autocmd BufWritePre * %s/\s\+$//e
vim.opt.bs = "2"

-- Tabs Spacing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Golang - use tabs instead of spaces
vim.cmd[[au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4]]

-- set ttymouse=xterm2
-- set ttymouse=sgr
vim.opt.mouse = "a"
vim.opt.hidden = true

-- Always display status bar
vim.opt.laststatus = 2
vim.opt.ruler = true

-- Line Number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.rnu = true

-- Highlight Cursor Line
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true

vim.g.rainbow_active = 1

-- Set title to current file name
vim.opt.title = true

-- Show commands as I type them.
vim.opt.showcmd = true

-- Max Characher Line
vim.opt.colorcolumn = "80"

-- clipboard
vim.opt.clipboard = "unnamed"

vim.api.nvim_set_keymap("i", "jj", "<Esc>", {})

vim.opt.completeopt = "menu,menuone,noselect"
