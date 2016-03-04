local lua51 = '^Lua 5%.1$'
local lua52 = '^Lua 5%.2$'
local lua53 = '^Lua 5%.3$'
local lua = '^Lua 5%.[1-3]$'
local lua52up = '^Lua 5%.[2-3]$'
local lj20 = "^LuaJIT2%.0.*"
local lj21 = "^LuaJIT2%.1.*"
local lj = "^LuaJIT.*"
local ljx = "^LuaJIT.*5%.[23]$"

return {

dont_run = {
	["ffi/callback"] = {ljx},
},

lua = {
	table_misc = {lj20},
	getfenv = {lua52up},
	mod0 = {lua53},
	setfenv = {lua52up,ljx},
	stackovc = {lua52},
	tonumbern = {lua53},
	coro_pcall = {lua51},
	debug_meta = {lua51},
	debug_meta_proxy = {lua},
	kfold2 = {lua51,lj21}, -- lj bug?
	kfold3 = {lua51,lj21}, -- lj bug?
	parse_esc = {lua51},
	string_byte = {lua51},
	string_sub = {lua51},
	string_op2 = {lua51},
	xpcall = {lua51},
	gotolabel = {lua}, -- lua bug?
	gotofmt = {ljx}
},

ffi = {
	arith_int64 = {lj20,ljx},
	bit64 = {lj20},
	new = {lj20},
	jit_arith = {ljx},
},

luajit = {
	math_special = {ljx},
},

jit = {
},

nojit = {
},

}
