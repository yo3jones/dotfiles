require('nvim-treesitter.configs').setup({
    -- ensure_installed = 'all',
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    },
    indent = {enable = false},
    textobjects = {
        -- syntax-aware textobjects
        enable = true,
        lsp_interop = {
            enable = true,
            peek_definition_code = {
                ['DF'] = '@function.outer'
                -- ['DF'] = '@class.outer'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                ['<leader>1'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- ['iL'] = {
                --   -- you can define your own textobjects directly here
                --   go = '(function_definition) @function',
                -- },
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['aC'] = '@class.outer',
                ['iC'] = '@class.inner',
                ['ac'] = '@conditional.outer',
                ['ic'] = '@conditional.inner',
                ['ae'] = '@block.outer',
                ['ie'] = '@block.inner',
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
                ['is'] = '@statement.inner',
                ['as'] = '@statement.outer',
                ['ad'] = '@comment.outer',
                ['am'] = '@call.outer',
                ['im'] = '@call.inner'
                -- Or you can define your own textobjects like this
                -- ['iF'] = {
                --   python = '(function_definition) @function',
                --   cpp = '(function_definition) @function',
                --   c = '(function_definition) @function',
                --   java = '(method_declaration) @function',
                --   go = '(method_declaration) @function'
                -- }
            }
        },
        swap = {
            enable = true,
            swap_next = {['<leader>a'] = '@parameter.inner'},
            swap_previous = {['<leader>A'] = '@parameter.inner'}
        }
    }
})
