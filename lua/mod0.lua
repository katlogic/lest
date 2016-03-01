do
  local x = 1%0
  assert(x ~= x)
  x = math.floor(0/0)
  assert(x ~= x)
end

