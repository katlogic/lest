local ffi = require("ffi")

ffi.cdef[[
int foo(const char *s) asm("strlen");
]]

assert(ffi.C.foo("abcd") == 4)

if ffi.abi("win") then
  ffi.cdef[[
  int bar asm("_fmode");
  ]]
else
  ffi.cdef[[
  int bar asm("errno");
  ]]
end

-- no errno
if ffi.abi('win') and ffi.os == 'POSIX' then return end

ffi.C.bar = 14
assert(ffi.C.bar == 14)
ffi.C.bar = 0

