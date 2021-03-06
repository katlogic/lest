local create = coroutine.create
local wrap = coroutine.wrap
local resume = coroutine.resume
local yield = coroutine.yield

-- Test stack overflow handling on return from coroutine.
do
  wrap(function()
    local co = create(function()
      yield(string.byte(string.rep(" ", 100), 1, 100))
    end)
    assert(select('#', resume(co)) == 101)
  end)()
end

do
  wrap(function()
    local f = wrap(function()
      yield(string.byte(string.rep(" ", 100), 1, 100))
    end)
    assert(select('#', f()) == 100)
  end)()
end

do
  local function cogen(x)
    return wrap(function(n) repeat x = x+n; n = yield(x) until false end),
	   wrap(function(n) repeat x = x*n; n = yield(x) until false end)
  end

  local a,b=cogen(3)
  local c,d=cogen(5)
  assert(d(b(c(a(d(b(c(a(1)))))))) == 168428160)
end


