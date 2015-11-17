#0,1,1,2,3,5,8,13,21...

defmodule Fibonacci do
  def nth_fib?(n) when n in [0, 1] do
    n
  end

  def nth_fib?(n) do
    nth_fib?(n - 1) + nth_fib?(n - 2)
  end
end

ExUnit.start

defmodule FibonacciTest do
  use ExUnit.Case

  test "nth_fib?" do
    assert Fibonacci.nth_fib?(3) == 2
    assert Fibonacci.nth_fib?(4) == 3
    assert Fibonacci.nth_fib?(5) == 5
    assert Fibonacci.nth_fib?(8) == 21
  end
end

