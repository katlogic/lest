do
  local y
  for i=1,100 do y = string.rep("ab", 10, "c") end
  assert(y == "abcabcabcabcabcabcabcabcabcab")
end

do
  local t = {}
  for i=1,100 do t[i] = string.rep("ab", i-85) end
  assert(t[100] == "ababababababababababababababab")
  for i=1,100 do t[i] = string.rep("ab", i-85, "c") end
  assert(t[85] == "")
  assert(t[86] == "ab")
  assert(t[87] == "abcab")
  assert(t[100] == "abcabcabcabcabcabcabcabcabcabcabcabcabcabcab")
end


