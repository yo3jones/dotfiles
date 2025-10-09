return {

  -- Markdown preview
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   enabled = false,
  -- },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    opts = {
      heading = {
        sign = true,
        icons = { "󰲡  ", "󰲣  ", "󰲥  ", "󰲧  ", "󰲩  ", "󰲫  " },
        width = "block",
        right_pad = 3,
        min_width = 80,
        border = false,
        border_virtual = true,
      },

      -- paragraph = {},

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

      -- bullet = {},

      checkbox = {
        enabled = true,
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'.
          icon = "󰱒 ",
          -- Highlight for the checked icon.
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox.
          scope_highlight = "RenderMarkdownCheckedScope",
        },
        -- Define custom checkbox states, more involved, not part of the markdown grammar.
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | raw             | matched against the raw text of a 'shortcut_link'           |
        -- | rendered        | replaces the 'raw' value when rendering                     |
        -- | highlight       | highlight for the 'rendered' icon                           |
        -- | scope_highlight | optional highlight for item associated with custom checkbox |
        -- stylua: ignore
        custom = {
            todo = { raw = '[-]', rendered = '󰄗 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
            todo_2 = { raw = '[~]', rendered = '󰄗 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
            waiting = { raw = '[>]', rendered = '󰥔 ', highlight = 'RenderMarkdownWaiting', scope_highlight = nil },
            alert = { raw = '[!]', rendered = '󰀦 ', highlight = 'RenderMarkdownAlert', scope_highlight = nil },
          -- ' '
          -- '󰐌 '
          -- '󰀦 '
          -- '󰳤 '
          -- '󰄱 '
          -- '󰄗 '
          -- '󰐋 '

        },
      },

      -- quote = {},

      pipe_table = {
        enabled = true,
        border_enabled = false,
      },

      -- callout = {},

      indent = {
        enabled = false,
      },

      link = {
        custom = {
          web = { pattern = "^http", icon = "󰖟 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
          google = { pattern = "google%.com", icon = "󰊭 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },

          -- Meta Internal
          googleInternSlide = { pattern = "/gslide/", icon = "󰊭 " },
          googleInternSheet = { pattern = "/gsheet/", icon = "󰊭 " },
          googleInternDoc = { pattern = "/gdoc/", icon = "󰊭 " },
          diff = { pattern = "/diff/", icon = " " },
          task = { pattern = "/tasks/", icon = " " },
          code = { pattern = "/code/", icon = " " },
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
