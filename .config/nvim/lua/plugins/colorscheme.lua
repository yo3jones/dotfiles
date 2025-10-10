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

return {
  {
    "ellisonleao/gruvbox.nvim",
    enabled = true,
    priority = 1000,
    config = true,
    opts = function(_, opts)
      local palette = require("gruvbox").palette
      local darken_percent = 0.85

      return vim.tbl_extend("force", opts, {
        strikethrough = true,
        contrast = "hard",
        overrides = {
          -- H1
          ["@markup.heading.1.markdown"] = {
            fg = palette.neutral_red,
            bold = true,
          },
          RenderMarkdownH1Bg = {
            fg = palette.neutral_red,
            bg = darken(palette.neutral_red, darken_percent),
            bold = true,
          },

          -- H2
          ["@markup.heading.2.markdown"] = {
            fg = palette.neutral_orange,
            bold = true,
          },
          RenderMarkdownH2Bg = {
            fg = palette.neutral_orange,
            bg = darken(palette.neutral_orange, darken_percent),
            bold = true,
          },

          -- H3
          ["@markup.heading.3.markdown"] = {
            fg = palette.bright_purple,
            bold = true,
          },
          RenderMarkdownH3Bg = {
            fg = palette.bright_purple,
            bg = darken(palette.bright_purple, darken_percent),
            bold = true,
          },

          -- H4
          ["@markup.heading.4.markdown"] = {
            fg = palette.bright_aqua,
            bold = true,
          },
          RenderMarkdownH4Bg = {
            fg = palette.bright_aqua,
            bg = darken(palette.bright_aqua, darken_percent),
            bold = true,
          },

          -- H5
          ["@markup.heading.5.markdown"] = {
            fg = palette.neutral_blue,
            bold = true,
          },
          RenderMarkdownH5Bg = {
            fg = palette.neutral_blue,
            bg = darken(palette.neutral_blue, darken_percent),
            bold = true,
          },

          -- H6
          ["@markup.heading.6.markdown"] = {
            fg = palette.neutral_yellow,
            bold = true,
          },
          RenderMarkdownH6Bg = {
            fg = palette.neutral_yellow,
            bg = darken(palette.neutral_yellow, darken_percent),
            bold = true,
          },

          -- Links
          RenderMarkdownLink = { fg = palette.bright_green },
          RenderMarkdownWikiLink = { fg = palette.bright_green },
          ["@markup.link.label.markdown_inline"] = { fg = palette.bright_blue },

          -- pipe_table
          -- ["@markup.heading.markdown"] = { fg = palette.bright_aqua, bold = true },
          ["@markup.heading.markdown"] = {
            fg = palette.bright_orange,
            bold = true,
          },
          RenderMarkdownTableHead = { fg = palette.neutral_orange },
          RenderMarkdownTableRow = { fg = palette.neutral_orange },

          -- @markup.strikethrough
          -- @markup.strikethrough.markdown_inline
          -- ["@markup.strikethrough"] = { strikethrough = true },
          -- ["@markup.strike"] = { strikethrough = true },
          -- ["@markup.strikethrough.markdown_inline"] = { strikethrough = true },

          -- Checkboxes
          RenderMarkdownCheckedScope = { strikethrough = true },
          RenderMarkdownWaiting = { fg = palette.bright_yellow },
          RenderMarkdownAlert = { fg = palette.bright_red },
        },
      })
    end,
  },

  {
    "sainnhe/gruvbox-material",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "hard"
      -- vim.g.gruvbox_material_foreground = "material"
      -- vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_foreground = "mixed"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },

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
