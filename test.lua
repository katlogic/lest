local deviants = require('deviants')
local dirs = { "lua", "luajit", "ffi", "nojit", "jit" }
local disabled = { luajit= true, ffi= true, nojit= true, jit= true }
local unpack = unpack or table.unpack
local E = setmetatable({}, {__index=function(t,k) return os.getenv(k) end})
local pos

if not arg[1] or arg[1]:sub(1,1) == '-' then
	-- use our own cli
	cmd = arg[-1]
	pos = 1
else
	-- use specified cli
	cmd = arg[1]
	pos = 2
end

local function str(sep, ...)
	local res = {}
	for _,v in ipairs {...} do
		table.insert(res, tostring(v))
	end
	return table.concat(res, sep)
end

local run = str(" ", cmd, unpack(arg, pos))

local function log(...)
	io.stdout:write(str("",...))
end

local function logn(...)
	log(...)
	log("\r\n")
end

local function pop(...)
	local cstr = run .. " " .. str(" ", ...)
	return io.popen(cstr, "r")
end
local trim = "^%s*(.-)%s*$"
local function popa(...)
	return pop(...):read("*a"):match(trim)
end

local function popf(...)
	local v = pop(...)
	local res = v:read("*a")
	-- this is lame, but windows does not report errors
	local vres = not res:match("stack traceback:")
	return vres, res
end

logn(">> Using '",cmd,"', full command '",run,"'")
local win32=(package.cpath:match("\\") and package.cpath:match("%.dll"))
if win32 then
	logn(">> Detected win32 host")
end

local getver = '"print((jit and jit.version and jit.version:gsub(\' \',\'\') or \'Lua\') .. _VERSION:match(\'Lua(.*)\'))"'
local tver = popa('-e',getver)
logn(">> Target version: "..tver)

disabled.luajit = not tver:match("LuaJIT")
if not disabled.luajit then
	disabled.nojit = false
	disabled.jit = not popf('-e','"assert(require(\'jit\').opt);return 0"','2>&1')
	disabled.ffi = not popf('-e','"require(\'ffi\');return 0"','2>&1')
end
logn(">> Target extensions: luajit/",not disabled.luajit, ", jit/",
	not disabled.jit, ", ffi/", not disabled.ffi, ", nojit/", not disabled.nojit)

local function dir(d)
	local ls=(win32 and io.popen("DIR /B "..d, "r")) or io.popen("ls -A1 "..d,"r")
	return ls:lines()
end

local errs={}
local devs={}
local function is_deviant(d,f)
	local dtab = deviants[d]
	if not dtab then return end
	local dn = f:match("^[^%.]+")
	local dent = dtab[dn]
	if not dent then return end
	local dlist = type(dent) == "table" and dent or {dent}
	for _,v in ipairs(dent) do
		-- found the culprit!
		if (tver:match(v)) then
			return true
		end
	end
end

for _,d in ipairs(dirs) do
	if not disabled[d] then
		log(">> ",d,"/")
		for f in dir(d) do
			local fn = d .. "/" .. f
			local alist = { fn, "2>&1" }
			if d == 'nojit' then
				alist = { '-joff', fn, '2>&1' }
			end
			local stat = '.'
			if is_deviant('dont_run',fn) then
				stat='S'
			else
				local ok, msg = popf(unpack(alist))
				if E.TDEBUG then
					log("  "..f.."...")
					stat='OK'
				end
				if not ok then
					if is_deviant(d,f) then
						stat = 'D'
						table.insert(devs, fn)
					elseif E.ESKIP=="1" then
						stat = 'E'
						errs[fn] = msg
					else
						logn()
						logn(">> Error in ",fn,"")
						log(msg)
						os.exit(1)
					end
				end
				if E.TDEBUG then
					logn(stat)
				else
					log(stat)
				end
			end
		end
		logn()
	end
end

log(">> Passed. Found ",#devs, " deviants: ", str(" ", unpack(devs)))
logn()
