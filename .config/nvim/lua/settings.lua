local opt = vim.opt

-- General Stuff
opt.compatible = false
-- filetype plugin on
-- set directory=$HOME/.vim/swap_files/
opt.spell = false
opt.spelllang = "en_us"
-- autocmd BufWritePre * %s/\s\+$//e
opt.bs = "2"

-- Tabs Spacing

-- Golang - use tabs instead of spaces
vim.cmd[[au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4]]

-- set ttymouse=xterm2
-- set ttymouse=sgr
opt.hidden = true

-- Always display status bar
opt.laststatus = 2
opt.ruler = true

-- Line Number
opt.number = true
opt.relativenumber = true
opt.nu = true
opt.rnu = true

-- Highlight Cursor Line
opt.cursorline = true
opt.cursorcolumn = true

opt.hlsearch = true

vim.g.rainbow_active = 1

-- Set title to current file name
opt.title = true

-- Show commands as I type them.
opt.showcmd = true

-- Max Characher Line
opt.colorcolumn = "80"

-- clipboard
opt.clipboard = "unnamed"

opt.completeopt = "menu,menuone,noselect"

opt.showmatch = true -- show matching brackets

opt.smartindent = true -- use c-like indents when no indentexpr is used
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- use 2 spaces when inserting tabs
opt.tabstop = 2 -- show tabs as 2 spaces
opt.softtabstop = 2

opt.splitright = true -- vsplit to right of current window
opt.splitbelow = true -- hsplit to bottom of current window

opt.scrolloff = 2 -- include 2 rows of context above/below current line
opt.sidescrolloff = 5 -- include 5 colums of context to the left/right of current column

opt.ignorecase = true -- ignore case in searches...
opt.smartcase = true -- ...unless we use mixed case

opt.joinspaces = false -- join lines without two spaces

opt.termguicolors = true -- allow true colors

opt.inccommand = "nosplit" -- show effects of substitute incrementally

opt.mouse = "a" -- enable mouse mode

opt.updatetime = 400 -- decrease time for cursorhold event

-- trying to use nvim-treesitter for folding
-- doesn't work well yet, want to be able to fold inside, not outside of a 
-- function/method
--
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
