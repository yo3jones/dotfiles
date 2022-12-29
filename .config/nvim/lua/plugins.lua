vim.cmd [[packadd packer.nvim]]

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'sainnhe/gruvbox-material' -- gruvbox theme
    use {'PHSix/faster.nvim', event = {'VimEnter *'}} -- scroll faster
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use {'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use {
        'kdheepak/tabline.nvim',
        requires = {
            {'hoob3rt/lualine.nvim', opt = true},
            {'kyazdani42/nvim-web-devicons', opt = true}
        }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons' -- optional, for file icon
        }
    }
    use 'numToStr/Comment.nvim'
    use 'christoomey/vim-tmux-navigator'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'neovim/nvim-lspconfig'
    use {'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim'}
    use 'liuchengxu/vista.vim'
    use 'L3MON4D3/LuaSnip'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline', 'rafamadriz/friendly-snippets',
            'molleweide/LuaSnip-snippets.nvim',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        }
        -- after = 'LuaSnip'
    }
    use {
        'saadparwaiz1/cmp_luasnip'
        -- after = 'nvim-cmp'
    }
    use {
        'windwp/nvim-autopairs'
        -- after = 'nvim-cmp'
    }
    use 'folke/which-key.nvim'
    use 'folke/lsp-colors.nvim'
    use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use 'ggandor/lightspeed.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'vimwiki/vimwiki'
    use 'williamboman/mason.nvim'

    -- use({
    --   "mhinz/vim-signify",
    --   -- after = "tokyonight.nvim",
    --   config = function()
    --     -- local colors = require("tokyonight.colors").setup({})
    --     -- local util = require("tokyonight.util")
    --
    --     -- util.highlight("SignifySignAdd", { link = "GitSignsAdd" })
    --     -- util.highlight("SignifySignChange", { link = "GitSignsChange" })
    --     -- util.highlight("SignifySignChangeDelete", { link = "GitSignsChange" })
    --     -- util.highlight("SignifySignDelete", { link = "GitSignsDelete" })
    --     -- util.highlight("SignifySignDeleteFirstLine", { link = "GitSignsDelete" })
    --
    --     vim.g.signify_sign_add = "▊"
    --     vim.g.signify_sign_change = "▊"
    --     vim.g.signify_sign_change_delete = "~"
    --   end,
    -- })

    -- use({
    --   "lukas-reineke/indent-blankline.nvim",
    --   config = function()
    --     require("indent_blankline").setup({
    --       char = "┊",
    --       filetype_exclude = { "help", "packer" },
    --       buftype_exclude = { "terminal", "nofile" },
    --       char_highlight = "LineNr",
    --       show_trailing_blankline_indent = false,
    --     })
    --   end,
    -- })
    --
    -- use({
    --   "akinsho/bufferline.nvim",
    --   requires = { "kyazdani42/nvim-web-devicons" },
    --   -- after = "tokyonight.nvim",
    --   config = function()
    --     -- local colors = require("tokyonight.colors").setup({})
    --
    --     require("bufferline").setup({
    --       options = {
    --         separator_style = "slant",
    --         offsets = {
    --           {
    --             filetype = "NvimTree",
    --             text = "File Explorer",
    --             highlight = "Directory",
    --             text_align = "left",
    --           },
    --         },
    --       },
    --       -- highlights = {
    --       --   fill = {
    --       --     guibg = colors.bg_statusline,
    --       --   },
    --       --   separator = {
    --       --     guifg = colors.bg_statusline,
    --       --   },
    --       --   separator_selected = {
    --       --     guifg = colors.bg_statusline,
    --       --   },
    --       --   separator_visible = {
    --       --     guifg = colors.bg_statusline,
    --       --   },
    --       -- },
    --     })
    --
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "gn",
    --       ":BufferLineCycleNext<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "gp",
    --       ":BufferLineCyclePrev<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "gq",
    --       ":BufferLinePickClose<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "gh",
    --       ":BufferLinePick<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "gb",
    --       ":b#<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "g]",
    --       ":BufferLineMoveNext<CR>",
    --       { noremap = true, silent = true }
    --     )
    --     vim.api.nvim_set_keymap(
    --       "n",
    --       "g[",
    --       ":BufferLineMovePrev<CR>",
    --       { noremap = true, silent = true }
    --     )
    --   end,
    -- })

    -- {{- if .ForTag "work" }}
    use {'/usr/share/fb-editor-support/nvim', as = 'meta.nvim'}
    -- {{- end }}

    -- use {
    --     'rmagatti/auto-session',
    --     config = function()
    --         require('auto-session').setup {
    --             -- log_level = 'info',
    --             -- auto_session_suppress_dirs = {'~/', '~/Projects'}
    --             auto_session_enable_last_session = false,
    --             auto_restore_enabled = false,
    --             auto_save_enabled = false
    --         }
    --         vim.o.sessionoptions =
    --             "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
    --     end
    -- }

    -- use {
    --     'rmagatti/session-lens',
    --     config = function()
    --         require('session-lens').setup({ --[[your custom config--]] })
    --     end
    -- }

    -- use 'mfussenegger/nvim-dap'
    -- use 'rcarriga/nvim-dap-ui'
    -- use 'theHamsta/nvim-dap-virtual-text'
    -- use 'ray-x/guihua.lua' -- recommanded if need floating window support
    -- use{
    --   'ray-x/go.nvim',
    --   config = function()
    --     -- vim.cmd([[
    --     --   autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
    --     -- ]])
    --     vim.cmd([[
    --       autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)
    --     ]])
    --     -- Run gofmt + goimport on save
    --     -- vim.cmd(
    --     --   [[
    --     --     autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    --     --   ]],
    --     --   false
    --     -- )
    --     vim.cmd([[
    --       autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
    --     ]])
    --     require('go').setup({
    --       goimport = 'gopls', -- if set to 'gopls' will use golsp format
    --       gofmt = 'gofumpt', -- if set to gopls will use golsp format
    --       max_line_len = 80,
    --       tag_transform = false,
    --       test_dir = '',
    --       comment_placeholder = '   ',
    --       lsp_cfg = true, -- false: use your own lspconfig
    --       lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    --       lsp_on_attach = true, -- use on_attach from go.nvim
    --       dap_debug = true,
    --     })
    --     -- vim.cmd("autocmd FileType go nmap <Leader><Leader>l GoLint")
    --     -- vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")
    --   end
    -- }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    -- if packer_bootstrap then
    --   require('packer').sync()
    -- end
end)
