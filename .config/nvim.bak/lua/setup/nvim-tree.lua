-- nvim-tree.git.ignore*
require('nvim-tree').setup {
    update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},
    git = {ignore = false}
}
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
