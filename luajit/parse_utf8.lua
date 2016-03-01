local loadstring = loadstring or load
-- UTF-8 identifiers.
assert(loadstring([[
local ä = 1
local aäa = 2
local äöü·€晶 = 3

assert(ä == 1)
assert(aäa == 2)
assert(äöü·€晶 == 3)

assert(#"ä" == 2)
assert(#"aäa" == 4)
assert(#"äöü·€晶" == 14)
]]))()

