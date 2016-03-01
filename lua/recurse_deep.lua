
do
  local function sum(n)
    if n == 1 then return 1 end
    return n + sum(n-1)
  end
  assert(sum(200) == 20100)
end

do
  local function fib(n)
    if n < 2 then return 1 end
    return fib(n-2) + fib(n-1)
  end
  assert(fib(15) == 987)
end

