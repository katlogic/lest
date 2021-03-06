local lua51 = '^Lua 5%.1$'
local lua52 = '^Lua 5%.2$'
local lua53 = '^Lua 5%.3$'
local lua = '^Lua 5%.[1-3]$'
local lua52up = '^Lua 5%.[2-3]$'
local lj20 = "^LuaJIT2%.0.*"
local lj21 = "^LuaJIT2%.1.*"
local lj   = "^LuaJIT2%.1%.0%-beta[1-9] .*"
local ljx  = "^LuaJIT.*LJX.*"

return {

-- if some test gets stuck completely, put it in here
dont_run = {
	["ffi/callback"] = {ljx},
	["lua/closure"] = {lj,ljx},
	["lua/stackov"] = {lua51},
},

lua = {
	utf8 = {lj,lua51,lua52,ljx},
	calls53 = {lj,lua51,ljx},
	files = {lj,ljx},
	literals = {lj,ljx},
	nextvar = {lj,ljx},
	env = {lj,lua51},
	table_misc = {lj20},
	getfenv = {lua52up},
	mod0 = {lua53},
	setfenv = {lua52up,ljx},
	stackovc = {lua52},
	tonumbern = {lua53},
	coro_pcall = {lua51},
	debug_meta = {lua51},
	debug_meta_proxy = {lua},
	kfold = {ljx},
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
	arith_int64 = {lj20},
	bit64 = {lj20},
	new = {lj20},
	--jit_arith = {ljx},
},

luajit = {
	math_special = {ljx},
},

jit = {
},

nojit = {
},

}
