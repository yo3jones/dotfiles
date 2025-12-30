local function hexToRgb(hexColor)
  -- Remove '#' if present
  hexColor = hexColor:gsub("#", "")

  -- Ensure the string has 6 characters (RRGGBB)
  if #hexColor ~= 6 then
    error("Invalid hex color format. Expected 6 characters (RRGGBB).")
  end

  -- Extract R, G, B components
  local r_hex = hexColor:sub(1, 2)
  local g_hex = hexColor:sub(3, 4)
  local b_hex = hexColor:sub(5, 6)

  -- Convert hex to decimal
  local r = tonumber(r_hex, 16)
  local g = tonumber(g_hex, 16)
  local b = tonumber(b_hex, 16)

  return r, g, b
end

local function darken(color, percent)
  local r, g, b = hexToRgb(color)

  r = r - (r * percent)
  g = g - (g * percent)
  b = b - (b * percent)

  return string.format("#%02x%02x%02x", r, g, b)
end

---@class MyColors
---@field bright_white string
---@field gruvbox_material_natural_red string
---@field gruvbox_material_natural_orange string
---@field gruvbox_material_natural_green string
---@field gruvbox_material_natural_aqua string
---@field gruvbox_material_natural_blue string
---@field gruvbox_material_natural_purple string
---@field gruvbox_material_natural_yellow string
---@field gruvbox_bright_red string
---@field gruvbox_bright_green string
---@field gruvbox_bright_yellow string
---@field gruvbox_bright_blue string
---@field gruvbox_bright_purple string
---@field gruvbox_bright_aqua string
---@field gruvbox_bright_orange string
---@field gruvbox_neutral_red string
---@field gruvbox_neutral_green string
---@field gruvbox_neutral_yellow string
---@field gruvbox_neutral_blue string
---@field gruvbox_neutral_purple string
---@field gruvbox_neutral_aqua string
---@field gruvbox_neutral_orange string
---@field gruvbox_faded_red string
---@field gruvbox_faded_green string
---@field gruvbox_faded_yellow string
---@field gruvbox_faded_blue string
---@field gruvbox_faded_purple string
---@field gruvbox_faded_aqua string
---@field gruvbox_faded_orange string
local my_colors = {
  bright_white = "#f9f5d7",

  -- Gruvbox Material
  gruvbox_material_natural_red = "#ea6962",
  gruvbox_material_natural_orange = "#e78a4e",
  gruvbox_material_natural_green = "#a9b665",
  gruvbox_material_natural_aqua = "#89b482",
  gruvbox_material_natural_blue = "#7daea3",
  gruvbox_material_natural_purple = "#d3869b",
  gruvbox_material_natural_yellow = "#d8a657",

  -- Gruvbox
  gruvbox_bright_red = "#fb4934",
  gruvbox_bright_green = "#b8bb26",
  gruvbox_bright_yellow = "#fabd2f",
  gruvbox_bright_blue = "#83a598",
  gruvbox_bright_purple = "#d3869b",
  gruvbox_bright_aqua = "#8ec07c",
  gruvbox_bright_orange = "#fe8019",
  gruvbox_neutral_red = "#cc241d",
  gruvbox_neutral_green = "#98971a",
  gruvbox_neutral_yellow = "#d79921",
  gruvbox_neutral_blue = "#458588",
  gruvbox_neutral_purple = "#b16286",
  gruvbox_neutral_aqua = "#689d6a",
  gruvbox_neutral_orange = "#d65d0e",
  gruvbox_faded_red = "#9d0006",
  gruvbox_faded_green = "#79740e",
  gruvbox_faded_yellow = "#b57614",
  gruvbox_faded_blue = "#076678",
  gruvbox_faded_purple = "#8f3f71",
  gruvbox_faded_aqua = "#427b58",
  gruvbox_faded_orange = "#af3a03",
}

---@class MyTheme
---@field heading_darken_percent number
---@field h1 string
---@field h2 string
---@field h3 string
---@field h4 string
---@field h5 string
---@field h6 string
---@field link_icon string
---@field link_url string
---@field link_label string
---@field pipe_table_heading string
---@field pipe_table_border string
---@field checkbox_icon_waiting string
---@field checkbox_icon_alert string
---@field header_key string
---@field header_value string
---@field header_punctuation string
---@field inline_code string
---@field bufferline_indicator_selected string
local my_theme = {
  -- Headings
  heading_darken_percent = 0.9,
  h1 = my_colors.gruvbox_material_natural_red,
  h2 = my_colors.gruvbox_material_natural_orange,
  h3 = my_colors.gruvbox_material_natural_green,
  h4 = my_colors.gruvbox_material_natural_aqua,
  h5 = my_colors.gruvbox_material_natural_blue,
  h6 = my_colors.gruvbox_material_natural_yellow,

  -- Links
  link_icon = my_colors.gruvbox_material_natural_green,
  link_url = my_colors.gruvbox_material_natural_blue,
  link_label = my_colors.gruvbox_material_natural_yellow,

  -- Pipe Tables
  pipe_table_heading = my_colors.gruvbox_bright_orange,
  pipe_table_border = my_colors.gruvbox_neutral_orange,

  -- Checkboxes
  checkbox_icon_waiting = my_colors.gruvbox_bright_yellow,
  checkbox_icon_alert = my_colors.gruvbox_bright_red,

  -- Highlight
  highlight = my_colors.bright_white,

  -- Obsidian Header
  header_key = my_colors.gruvbox_material_natural_aqua,
  header_value = my_colors.gruvbox_material_natural_green,
  header_punctuation = my_colors.gruvbox_material_natural_orange,

  -- Code
  inline_code = my_colors.gruvbox_material_natural_green,

  -- Bufferline
  bufferline_indicator_selected = my_colors.gruvbox_bright_blue,
}

return {
  {
    "f4z3r/gruvbox-material.nvim",
    name = "gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      local colors =
        require("gruvbox-material.colors").get(vim.o.background, "hard")
      local darken_percent = 0.85

      -- vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", {
      --   fg = colors.red,
      --   bg = darken(colors.red, darken_percent),
      --   bold = true,
      -- })

      require("gruvbox-material").setup({
        contrast = "hard",
      })

      vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", {
        fg = colors.red,
        bg = darken(colors.red, darken_percent),
        bold = true,
      })
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    priority = 1000,
    config = true,
    opts = function(_, opts)
      return vim.tbl_extend("force", opts, {
        strikethrough = true,
        contrast = "hard",
        overrides = {
          -- H1
          ["@markup.heading.1.markdown"] = {
            fg = my_theme.h1,
            bold = true,
          },
          RenderMarkdownH1Bg = {
            fg = my_theme.h1,
            bg = darken(my_theme.h1, my_theme.heading_darken_percent),
            bold = true,
          },

          -- H2
          ["@markup.heading.2.markdown"] = {
            fg = my_theme.h2,
            bold = true,
          },
          RenderMarkdownH2Bg = {
            fg = my_theme.h2,
            bg = darken(my_theme.h2, my_theme.heading_darken_percent),
            bold = true,
          },

          -- H3
          ["@markup.heading.3.markdown"] = {
            fg = my_theme.h3,
            bold = true,
          },
          RenderMarkdownH3Bg = {
            fg = my_theme.h3,
            bg = darken(my_theme.h3, my_theme.heading_darken_percent),
            bold = true,
          },

          -- H4
          ["@markup.heading.4.markdown"] = {
            fg = my_theme.h4,
            bold = true,
          },
          RenderMarkdownH4Bg = {
            fg = my_theme.h4,
            bg = darken(my_theme.h4, my_theme.heading_darken_percent),
            bold = true,
          },

          -- H5
          ["@markup.heading.5.markdown"] = {
            fg = my_theme.h5,
            bold = true,
          },
          RenderMarkdownH5Bg = {
            fg = my_theme.h5,
            bg = darken(my_theme.h5, my_theme.heading_darken_percent),
            bold = true,
          },

          -- H6
          ["@markup.heading.6.markdown"] = {
            fg = my_theme.h6,
            bold = true,
          },
          RenderMarkdownH6Bg = {
            fg = my_theme.h6,
            bg = darken(my_theme.h6, my_theme.heading_darken_percent),
            bold = true,
          },

          -- Links
          RenderMarkdownLink = { fg = my_theme.link_icon },
          RenderMarkdownWikiLink = { fg = my_theme.link_icon },
          ["@markup.link.label.markdown_inline"] = { fg = my_theme.link_label },
          ["@lsp.type.class.markdown"] = { fg = my_theme.link_label },
          ["@markup.link.markdown_inline"] = { fg = my_theme.link_url },
          ["@markup.link.url.markdown_inline"] = {
            fg = my_theme.link_url,
            underline = true,
          },

          -- pipe_table
          -- ["@markup.heading.markdown"] = { fg = palette.bright_aqua, bold = true },
          ["@markup.heading.markdown"] = {
            fg = my_theme.pipe_table_heading,
            bold = true,
          },
          RenderMarkdownTableHead = { fg = my_theme.pipe_table_border },
          RenderMarkdownTableRow = { fg = my_theme.pipe_table_border },

          -- @markup.strikethrough
          -- @markup.strikethrough.markdown_inline
          -- ["@markup.strikethrough"] = { strikethrough = true },
          -- ["@markup.strike"] = { strikethrough = true },
          -- ["@markup.strikethrough.markdown_inline"] = { strikethrough = true },

          -- Checkboxes
          RenderMarkdownCheckedScope = { strikethrough = true },
          RenderMarkdownWaiting = { fg = my_theme.checkbox_icon_waiting },
          RenderMarkdownAlert = { fg = my_theme.checkbox_icon_alert },

          -- Highlight `==this is a highlight==`
          RenderMarkdownInlineHighlight = {
            fg = my_theme.highlight,
            bold = true,
            underline = true,
          },

          -- Headers
          ["@property.yaml"] = { fg = my_theme.header_key },
          ["@string.yaml"] = { fg = my_theme.header_value },
          ["@punctuation.bracket.yaml"] = { fg = my_theme.header_punctuation },

          -- Code
          RenderMarkdownCodeInline = { fg = my_theme.inline_code },
        },
      })
    end,
  },

  -- {
  --   "sainnhe/gruvbox-material",
  --   enabled = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_background = "hard"
  --     -- vim.g.gruvbox_material_foreground = "material"
  --     -- vim.g.gruvbox_material_foreground = "original"
  --     vim.g.gruvbox_material_foreground = "mixed"
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_enable_italic = 1
  --   end,
  -- },

  -- {
  --   "navarasu/onedark.nvim",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("onedark").setup({
  --       -- style = "warmer",
  --       style = "darker",
  --     })
  --     -- Enable theme
  --     -- require("onedark").load()
  --   end,
  -- },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- indicator = {
        --   style = "underline",
        -- },
      },
      highlights = {
        -- tab_selected = { fg = "red", bg = "red" },
        -- tab_separator = { fg = "red", bg = "red" },
        -- buffer_selected = {
        --   fg = "red",
        --   bg = "red",
        --   bold = true,
        --   italic = true,
        -- },
        -- separator_selected = {
        --   fg = "red",
        --   bg = "red",
        -- },
        indicator_selected = {
          fg = my_theme.bufferline_indicator_selected,
          -- bg = my_theme.bufferline_indicator_selected,
        },
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "onedark",
      -- colorscheme = "gruvbox-material",
      colorscheme = "gruvbox",
    },
  },
}
