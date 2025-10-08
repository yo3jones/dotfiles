return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "block",
        min_width = 80,
      },

      code = {
        sign = true,
        conceal_delimiters = false,
        width = "block",
        right_pad = 1,
        min_width = 80,
        border = "thin",
      },

      dash = {
        width = 80,
      },

      pipe_table = {
        enabled = true,
        border_enabled = false,
      },

      indent = {
        enabled = false,
      },

      checkbox = {
        enabled = true,
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'.
          icon = "󰱒 ",
          -- Highlight for the checked icon.
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox.
          scope_highlight = "RenderMarkdownCheckedItem",
        },
      },
    },
  },

  {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
    opts = {
      processor = "magick_cli",
      integrations = {
        markdown = {
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "inline",
          resolve_image_path = function(document_path, image_path, fallback)
            local start_index, _ = string.find(image_path, "|")

            if start_index then
              image_path = string.sub(image_path, 1, start_index - 1)
            end

            return fallback(document_path, "assets/" .. image_path)
          end,
        },
      },
    },
  },
}
