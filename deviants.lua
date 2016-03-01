local lua51 = '^Lua 5%.1$'
local lua52 = '^Lua 5%.2$'
local lua53 = '^Lua 5%.3$'
local lua = '^Lua 5%.[1-3]$'
local lua52up = '^Lua 5%.[2-3]$'
local lj52 = '^LuaJIT[^ ]+ 5%.2$'
local lj51 = '^LuaJIT[^ ]+ 5%.1$'
local lj20 = "^LuaJIT2%.0.*"
local lj = "^LuaJIT.*"
local lj21 = "^LuaJIT2%.1*"

return {

lua = {
	argcheck = {lj20},
	libfuncs = {lj20},
	table_misc = {lj20},
	getfenv = {lua52up},
	mod0 = {lua53},
	setfenv = {lua52up},
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
	gotolabel = {lj} -- lj bug?
},

ffi = {
	arith_int64 = {lj20},
	bit64 = {lj20},
	new = {lj20},
}

}
