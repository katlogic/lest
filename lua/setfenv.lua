do
  local x = false
  local co = coroutine.create(function() print(1) end)
  debug.setfenv(co, setmetatable({}, { __index = {
    tostring = function() x = true end }}))
  coroutine.resume(co)
  assert(x == true)
end


