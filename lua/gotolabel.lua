-- Label prevents joining to KNIL.
do
  local k = 0
  local x
  ::foo::
  local y
  assert((y == nil and k == 0) or (y == true and k > 0))
  y = true
  k = k + 1
  if k < 2 then goto foo end
end


