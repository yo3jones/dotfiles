local function hex_to_rgb(hex_color_string)
  local clean_hex = string.gsub(hex_color_string, "#", "")

  if #clean_hex ~= 6 then
    error("Invalid hex color string format. Expected RRGGBB.")
  end

  local red_hex = string.sub(clean_hex, 1, 2)
  local green_hex = string.sub(clean_hex, 3, 4)
  local blue_hex = string.sub(clean_hex, 5, 6)

  local red_int = tonumber(red_hex, 16)
  local green_int = tonumber(green_hex, 16)
  local blue_int = tonumber(blue_hex, 16)

  return red_int, green_int, blue_int
end

local function darken(color, percent)
  local r, g, b = hex_to_rgb(color)

  return string.format("#%02X%02X%02X", r - (r * percent), g - (g * percent), b - (b * percent))
end

return {
  -- {
  --   "sainnhe/gruvbox-material",
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_palette = "original"
  --     vim.g.gruvbox_material_better_performance = 1
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_enable_italic = 1
  --   end,
  -- },

  {
    "ellisonleao/gruvbox.nvim",
    config = true,
    priority = 1000,
    opts = function(_, opts_in)
      local palette = require("gruvbox").palette

      ---@type GruvboxConfig
      local opts = {
        contrast = "hard",
        overrides = {
          -- H1
          RenderMarkdownH1Bg = { fg = palette.bright_red, bg = darken(palette.bright_red, 0.9) },
          ["@markup.heading.1.markdown"] = { fg = palette.bright_red },

          -- H2
          RenderMarkdownH2Bg = { fg = palette.bright_yellow, bg = darken(palette.bright_yellow, 0.9) },
          ["@markup.heading.2.markdown"] = { fg = palette.bright_yellow },

          -- H3
          RenderMarkdownH3Bg = { fg = palette.bright_green, bg = darken(palette.bright_green, 0.9) },
          ["@markup.heading.3.markdown"] = { fg = palette.bright_green },

          -- H4
          RenderMarkdownH4Bg = { fg = palette.bright_aqua, bg = darken(palette.bright_aqua, 0.9) },
          ["@markup.heading.4.markdown"] = { fg = palette.bright_aqua },

          -- H5
          RenderMarkdownH5Bg = { fg = palette.bright_blue, bg = darken(palette.bright_blue, 0.9) },
          ["@markup.heading.5.markdown"] = { fg = palette.bright_blue },

          -- Links
          ["@markup.link.label.markdown_inline"] = { fg = palette.bright_blue },
          RenderMarkdownLink = { fg = palette.bright_yellow },
          RenderMarkdownWikiLink = { fg = palette.bright_yellow },
          -- ["@markup.link.label.markdown_inline"] = { fg = palette.bright_yellow },
          -- RenderMarkdownWikiLink = { fg = palette.bright_blue },
          -- RenderMarkdownLink = { fg = palette.bright_blue },

          -- Pipe Table
          ["@markup.heading.markdown"] = { fg = palette.bright_orange },
          RenderMarkdownTableHead = { fg = palette.bright_orange },
          RenderMarkdownTableRow = { fg = palette.bright_orange },

          -- Checkbox
          RenderMarkdownCheckedItem = { strikethrough = true },
        },
      }

      return vim.tbl_extend("force", opts_in, opts)
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox-material",
      colorscheme = "gruvbox",
    },
  },
}
