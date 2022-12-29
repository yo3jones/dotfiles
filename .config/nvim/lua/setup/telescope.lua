-- local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {},
    pickers = {
        find_files = {hidden = true},
        buffers = {
            mappings = {
                i = {['<C-d>'] = require('telescope.actions').delete_buffer},
                n = {['<C-d>'] = require('telescope.actions').delete_buffer}
            }
        }
    }
}
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('session-lens')

vim.api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files<cr>',
                        {noremap = true, silent = true});
-- {{- if .ForTag "work" }}
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>Telescope myles<CR>]],
                        {noremap = true, silent = true})
-- {{- else }}
vim.api.nvim_set_keymap('n', '<leader>p', ':Telescope live_grep<cr>',
                        {noremap = true, silent = true})
-- {{- end }}
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>g', ':Telescope treesitter<cr>',
                        {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>s',
--                         ':Telescope session-lens search_session<cr>',
--                         {noremap = true, silent = true})
