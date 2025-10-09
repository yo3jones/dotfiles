require("which-key").add({
  { "<leader>o", name = "+Obsidian" },
})

return {
  {
    "obsidian-nvim/obsidian.nvim",
    enabled = true,
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    opts = {
      ui = {
        enable = false,
      },

      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Yo3",
        },
        {
          name = "Meta",
          path = "~/obsidian-vault/Meta",
        },
      },

      -- completion = {
      --   blink = true,
      -- },

      picker = {
        name = "snacks.pick",
      },

      daily_notes = {
        folder = "Daily Notes",
        date_format = "%Y-%m-%d %A",
      },

      note_id_func = function(title)
        return title
      end,
    },
  },
}
