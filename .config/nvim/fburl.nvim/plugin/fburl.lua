if vim.g.loaded_fburl then
  return
end
vim.g.loaded_fburl = true

vim.api.nvim_create_user_command("FburlLink", function(args)
  require("fburl").shorten({
    range = args.range > 0 and { args.line1, args.line2 } or nil,
  })
end, {
  range = true,
  desc = "Replace link URL(s) with an fburl.com short link",
})
