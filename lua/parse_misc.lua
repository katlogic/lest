
-- Ambiguous syntax: function call vs. new statement.
local loadstring = loadstring or load
if (jit and rawlen) or (_VERSION ~= "Lua 5.1") then
  assert(assert(loadstring([[
local function f() return 99 end
return f
()
]]))() == 99)
else
  assert(loadstring([[
local function f() return 99 end
return f
()
]]) == nil)
end


