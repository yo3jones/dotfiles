require('trouble').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

local signs = {Error = ' ', Warn = ' ', Hint = ' ', Info = ' '}

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

vim.api.nvim_set_keymap('n', '<leader>t', ':TroubleToggle<cr>',
                        {noremap = true, silent = true})
