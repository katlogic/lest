do
  for i=1,100 do
    assert(bit.tobit(i+0x7fffffff) < 0)
  end
  for i=1,100 do
    assert(bit.tobit(i+0x7fffffff) <= 0)
  end
end

