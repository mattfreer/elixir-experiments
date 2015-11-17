#Write a program that prints the numbers from 1 to 100.
#But for multiples of three print “Fizz” instead of the number
#and for the multiples of five print “Buzz”. For numbers which
#are multiples of both three and five print “FizzBuzz”.

defmodule FizzBuzz do
  def execute(max \\ 100) do
    1..max
    |> Enum.into([])
    |> Enum.map(fn(num) -> match(num, remainders(num)) end)
  end

  defp remainders(num) do
    {
      rem(num, 3),
      rem(num, 5),
    }
  end

  defp match(_num, {0,0}) do
    "FizzBuzz"
  end

  defp match(_num, {0,f}) when f > 0 do
    "Fizz"
  end

  defp match(_num, {t,0}) when t > 0 do
    "Buzz"
  end

  defp match(num, _r) do
    num
  end
end

ExUnit.start

defmodule FizzBuzzTest do
  use ExUnit.Case

  test :execute do
    assert FizzBuzz.execute(15) == [
      1,2,"Fizz",4,"Buzz","Fizz",7,8,"Fizz","Buzz", 11, "Fizz", 13, 14, "FizzBuzz"
    ]
  end
end

