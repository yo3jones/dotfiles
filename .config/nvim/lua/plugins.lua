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
        highlight = {
          enable = true,
          disable = { "latex" },
        },
        indent = {
          enable = true,
          disable = { "python", "lua", "latex" },
        },
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
