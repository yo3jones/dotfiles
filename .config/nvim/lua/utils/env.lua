local M = {}

M.isWork = function()
  return os.getenv("USER") == "cpj"
end

M.isNotWork = function()
  return not M.isWork()
end

M.select = function(notWork, work)
  local is_not_work = M.isNotWork()
  if is_not_work then
    return notWork
  end
  return work
end

return M
