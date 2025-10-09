local M = {}

M.isWork = function()
  return os.getenv("USER") == "cpj"
end

M.isNotWork = function()
  return not M.isWork()
end

M.select = function(notWork, work)
  return M.isNotWork() and notWork or work
end

return M
