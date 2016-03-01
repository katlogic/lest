do
  local pcall = pcall
  local tr1
  local x = 0
  function tr1(n)
    if n <= 0 then return end
    x = x + 1
    return pcall(tr1, n-1)
  end
  assert(tr1(200) == true and x == 200)
end


