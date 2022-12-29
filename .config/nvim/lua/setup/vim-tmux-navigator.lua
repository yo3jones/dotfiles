vim.api.nvim_set_keymap('n', '<C-h>', ':tmuxNavigateLeft<cr>',
                        {noremap = true, silent = true});
vim.api.nvim_set_keymap('n', '<C-j>', ':tmuxNavigateDown<cr>',
                        {noremap = true, silent = true});
vim.api.nvim_set_keymap('n', '<C-k>', ':tmuxNavigateUp<cr>',
                        {noremap = true, silent = true});
vim.api.nvim_set_keymap('n', '<C-l>', ':tmuxNavigateRight<cr>',
                        {noremap = true, silent = true});
vim.api.nvim_set_keymap('n', '<C-\\>', ':tmuxNavigatePrevious<cr>',
                        {noremap = true, silent = true});
