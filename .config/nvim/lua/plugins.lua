vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use({
    "sainnhe/gruvbox-material",
    config = function()
      vim.opt.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_palette = "original"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.cmd("colorscheme gruvbox-material")
    end,
  })

  use({
    "PHSix/faster.nvim",
    event = {"VimEnter *"},
    config = function()
      -- vim.api.nvim_set_keymap(
      --   'n', 
      --   'j', 
      --   '<Plug>(faster_move_j)', 
      --   {noremap=false, silent=true}
      -- )
      -- vim.api.nvim_set_keymap(
      --   'n', 
      --   'k', 
      --   '<Plug>(faster_move_k)', 
      --   {noremap=false, silent=true}
      -- )
      -- or 
      vim.api.nvim_set_keymap(
        'n', 
        'j', 
        '<Plug>(faster_move_gj)',
        {noremap=false, silent=true}
      )
      vim.api.nvim_set_keymap(
        'n', 
        'k', 
        '<Plug>(faster_move_gk)', 
        {noremap=false, silent=true}
      )
      -- if you need map in visual mode
      -- vim.api.nvim_set_keymap(
      --   'v', 
      --   'j', 
      --   '<Plug>(faster_vmove_j)', 
      --   {noremap=false, silent=true}
      -- )
      -- vim.api.nvim_set_keymap(
      --   'v', 
      --   'k',
      --   '<Plug>(faster_vmove_k)',
      --   {noremap=false, silent=true}
      -- )
    end
  })

  use("junegunn/fzf")
  use("junegunn/fzf.vim")

  use({
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox-material",
        },
      })
    end,
  })

  use {
    'kdheepak/tabline.nvim',
    config = function()
      require'tabline'.setup {
        -- Defaults configuration options
        enable = true,
        options = {
        -- If lualine is installed tabline will use separators configured in
        -- lualine by default.
        -- These options can be used to override those settings.
          section_separators = {'', ''},
          component_separators = {'', ''},
          -- set to nil by default, and it uses vim.o.columns * 2/3
          max_bufferline_percent = 66,
          -- this shows tabs only when there are more than one tab or if the
          -- first tab is named
          show_tabs_always = false,
          show_devicons = true, -- this shows devicons in buffer section
          show_bufnr = true, -- this appends [bufnr] to buffer section,
          -- shows base filename only instead of relative path in filename
          show_filename_only = false,
          modified_icon = "+ ", -- change the default modified icon
          -- set to true by default; this determines whether the filename turns
          -- italic if modified
          modified_italic = true,
          -- this shows only tabs instead of tabs + buffers
          show_tabs_only = false,
        }
      }
      vim.cmd[[
        " Use showtabline in gui vim
        set guioptions-=e
        " store tabpages and globals in session
        set sessionoptions+=tabpages,globals
      ]]
    end,
    requires = {
      { 'hoob3rt/lualine.nvim', opt=true },
      {'kyazdani42/nvim-web-devicons', opt = true}
    }
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    config = function()
      require"nvim-tree".setup {
        update_focused_file = {
          enable = true,
          update_cwd = false,
          ignore_list = {},
        },
      }
      vim.api.nvim_set_keymap(
        "n",
        "<C-n>",
        ":NvimTreeToggle<CR>",
        { noremap = true }
      )
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<C-h>",
        ":tmuxNavigateLeft<cr>",
        { noremap = true, silent = true }
      );
      vim.api.nvim_set_keymap(
        "n",
        "<C-j>",
        ":tmuxNavigateDown<cr>",
        { noremap = true, silent = true }
      );
      vim.api.nvim_set_keymap(
        "n",
        "<C-k>",
        ":tmuxNavigateUp<cr>",
        { noremap = true, silent = true }
      );
      vim.api.nvim_set_keymap(
        "n",
        "<C-l>",
        ":tmuxNavigateRight<cr>",
        { noremap = true, silent = true }
      );
      vim.api.nvim_set_keymap(
        "n",
        "<C-\\>",
        ":tmuxNavigatePrevious<cr>",
        { noremap = true, silent = true }
      );
    end
  }

  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- ensure_installed = "all",
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        indent = {
          enable = false
        },
        textobjects = {
          -- syntax-aware textobjects
          enable = true,
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ["DF"] = "@function.outer",
              ["DF"] = "@class.outer"
            }
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["<leader>1"] = "@function.outer",
              ["]]"] = "@class.outer"
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer"
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer"
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer"
            }
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- ["iL"] = {
              --   -- you can define your own textobjects directly here
              --   go = "(function_definition) @function",
              -- },
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aC"] = "@class.outer",
              ["iC"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ae"] = "@block.outer",
              ["ie"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["is"] = "@statement.inner",
              ["as"] = "@statement.outer",
              ["ad"] = "@comment.outer",
              ["am"] = "@call.outer",
              ["im"] = "@call.inner",
              -- Or you can define your own textobjects like this
              -- ["iF"] = {
              --   python = "(function_definition) @function",
              --   cpp = "(function_definition) @function",
              --   c = "(function_definition) @function",
              --   java = "(method_declaration) @function",
              --   go = "(method_declaration) @function"
              -- }
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner"
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner"
            }
          }
        }
      })
    end,
  })

  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    config = function ()
      local actions = require("telescope.actions")
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close
            },
          }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        }
      }
      require('telescope').load_extension('fzf')

      vim.api.nvim_set_keymap(
        "n",
        "<C-p>",
        ":Telescope find_files<cr>",
        { noremap = true, silent = true }
      );
      {{- if .ForTag "work" }}
      vim.api.nvim_set_keymap(
        "n",
        "<leader>p",
        [[<cmd>Telescope myles<CR>]],
        { noremap = true, silent = true }
      )
      {{ else }}
       vim.api.nvim_set_keymap(
         "n",
         "<leader>p",
         ":Telescope live_grep<cr>",
         { noremap = true, silent = true }
       )
      {{ end -}}
      vim.api.nvim_set_keymap(
        "n",
        "<leader>b",
        ":Telescope buffers<cr>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>g",
        ":Telescope treesitter<cr>",
        { noremap = true, silent = true }
      )
    end
  }

  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("neovim/nvim-lspconfig")

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  use({
    "liuchengxu/vista.vim",
    config = function()
      vim.g.vista_default_executive = "nvim_lsp"
    end,
  })

  use("L3MON4D3/LuaSnip")

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "rafamadriz/friendly-snippets",
      "molleweide/LuaSnip-snippets.nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
    after = "LuaSnip",
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
          }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lsp_signature_help" },
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.snippets = require("luasnip_snippets").load_snippets()
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup({})

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
      )
    end,
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  use {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup({})
    end,
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }

      local signs = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " "
      }

      for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
      end

      vim.api.nvim_set_keymap(
        "n",
        "<leader>t",
        ":TroubleToggle<cr>",
        { noremap = true, silent = true }
      )
    end
  }

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

  use("ggandor/lightspeed.nvim")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")

  use {
    'vimwiki/vimwiki',
    config = function()
      -- nmap  <Leader>wv <Plug>VimwikiVSplitLink
      vim.g.vimwiki_list = {
        {
          name = 'Work',
          path = '~/notes/work/',
          syntax = 'markdown',
          ext = '.md'
        },
        {
          name = 'Personal',
          path = '~/notes/personal/',
          syntax = 'markdown',
          ext = '.md'
        },
      }
    end
  }

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

  {{- if .ForTag "work" }}

  use({ "/usr/share/fb-editor-support/nvim", as = "meta.nvim" })
  {{- end }}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
