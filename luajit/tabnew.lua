-- table.new
do
  local tnew = require("table.new")
  local x, y
  for i=1,100 do
    x = tnew(100, 30)
    if i == 90 then y = x end
  end
  assert(x ~= y)
end


