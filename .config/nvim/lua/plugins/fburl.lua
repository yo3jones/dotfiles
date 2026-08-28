return {
  -- Shorten links to fburl.com
  -- :FburlLink
  {
    name = "fburl.nvim",
    enabled = require("utils/env").select(false, true),
    dir = vim.fn.stdpath("config") .. "/fburl.nvim",
    cmd = "FburlLink",
    keys = {
      {
        "<leader>cu",
        "<cmd>FburlLink<cr>",
        desc = "FBUrl - Shorten link url",
        ft = "markdown",
      },
      {
        "<leader>cu",
        ":FburlLink<cr>",
        mode = "v",
        desc = "FBUrl - Shorten link urls in selection",
        ft = "markdown",
      },
    },
  },
}
