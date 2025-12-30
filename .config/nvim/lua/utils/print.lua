local M = {}

M.formatNumStr = function(number)
  local left, num, right = string.match(number, "^([^%d]*%d)(%d*)(.-)$")
  num = num:reverse():gsub("(%d%d%d)", "%1,"):reverse()
  return left .. num .. right
end

M.formatNum = function(number)
  return M.formatNumStr(tostring(number))
end

M.isFloat = function(number)
  return string.find(tostring(number), ".")
end

M.formatCurrInt = function(number)
  return string.format("$%s", M.formatNumStr(string.format("%d", number)))
end

M.formatCurrFloat = function(number)
  return string.format("$%s", M.formatNumStr(string.format("%.2f", number)))
end

M.formatCurr = function(number)
  if M.isFloat(number) then
    return M.formatCurrFloat(number)
  else
    return M.formatCurrInt(number)
  end
end

M.printf = function(fmt, ...)
  print(string.format(fmt, ...))
end

M.printHeader = function(text)
  print()
  M.printf("## %s", text)
  print()
end

M.printSep = function()
  print()
  print("-------------------------------------")
end

-- local reduce = function(list, fn, init)
--   local acc = init
--   for k, v in ipairs(list) do
--     acc = fn(acc, k, v)
--   end
--   return acc
-- end

local pad = function(str, total_count, pad, direction)
  if direction == "before" then
    return string.format("%s%s", string.rep(pad, total_count - #str), str)
  else
    return string.format("%s%s", str, string.rep(pad, total_count - #str))
  end
end

local Table = {}
Table.__index = Table

function Table:new(headers)
  local new_table = {}
  setmetatable(new_table, Table)
  new_table.headers = headers
  new_table.rows = {}
  return new_table
end

function Table:row(columns)
  table.insert(self.rows, columns)
end

function Table:print()
  local widths = {}
  for _, header in ipairs(self.headers) do
    table.insert(widths, #header)
  end

  for _, row in ipairs(self.rows) do
    for i, column in ipairs(row) do
      widths[i] = math.max(widths[i], #column)
    end
  end

  local header_str = "|"
  local divider_str = "|"
  for i, header in ipairs(self.headers) do
    header_str =
      string.format("%s %s |", header_str, pad(header, widths[i], " "))
    divider_str = string.format("%s %s |", divider_str, pad("", widths[i], "-"))
  end
  print(header_str)
  print(divider_str)

  for _, row in ipairs(self.rows) do
    local row_str = "|"
    for i, column in ipairs(row) do
      row_str = string.format("%s %s |", row_str, pad(column, widths[i], " "))
    end
    print(row_str)
  end
end

M.createTable = function(headers)
  return Table:new(headers)
end

return M
