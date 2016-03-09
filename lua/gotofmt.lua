local loadstring = loadstring or load
do
  local function expect(src, msg)
    local ok, err = loadstring(src)
    print(ok,err,msg)
    if msg then
      assert(not ok and string.find(err, msg))
    else
      assert(ok)
    end
  end

  if (jit and rawlen) or (_VERSION ~= "Lua 5.1") then
    expect("goto = 1", "<name>")
  else
    expect("goto = 1")
  end

end
