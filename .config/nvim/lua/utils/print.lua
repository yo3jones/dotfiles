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

return M
