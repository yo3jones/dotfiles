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
        ensure_installed = "all",
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
      vim.api.nvim_set_keymap(
        "n",
        "<leader>p",
        ":Telescope buffers<cr>",
        { noremap = true, silent = true }
      );
      vim.api.nvim_set_keymap(
        "n",
        "<leader>r",
        ":Telescope live_grep<cr>",
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
      "hrsh7th/cmp-cmdline"
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
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- use("ggandor/lightspeed.nvim")
  --
  -- use("tpope/vim-commentary")
  -- use("tpope/vim-surround")
  -- use("tpope/vim-repeat")
  --
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
  --
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
