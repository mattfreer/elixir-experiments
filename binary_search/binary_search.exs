defmodule BinarySearch do
  def chop(_value, []) do
    -1
  end

  def chop(value, [head|[]]) do
    if head == value do
      0
    else
      -1
    end
  end

  def chop(value, list) do
    chop(value, 0, (length(list) - 1), list)
  end

  # Base case
  defp chop(value, left, right, list) when (right - left) == 1 do
    cond do
      Enum.at(list,left) == value -> left
      Enum.at(list,right) == value -> right
      true -> -1
    end
  end

  # Recursive
  defp chop(value, left, right, list) do
    middle = {mid_index, mid_value} = middle?(left, right, list)

    if value == mid_value do
      mid_index
    else
      {next_left, next_right} = next_bounds?(value, {left, right}, middle)
      chop(value, next_left, next_right, list)
    end
  end

  defp next_bounds?(value, {left, right} = _existing, {mid_index, mid_value}) do
    if value > mid_value do
      {(mid_index + 1), right}
    else
      {left, (mid_index - 1)}
    end
  end

  defp middle?(left, right, list) do
    index = round((right - left)/2)
    {
      index,
      Enum.at(list, index)
    }
  end
end
#-----------------------------------

ExUnit.start

defmodule BinarySearchTest do
  use ExUnit.Case

  test :chop do
    assert BinarySearch.chop(3, []) == -1
    assert BinarySearch.chop(3, [3]) == 0
    assert BinarySearch.chop(3, [4]) == -1
    assert BinarySearch.chop(4, [1,2,3,4,5]) == 3
    assert BinarySearch.chop(2, [1,2,3,4,5]) == 1
    assert BinarySearch.chop(5, [1,2,3,4,5]) == 4
    assert BinarySearch.chop(1, [1,2,3,4,5]) == 0
    assert BinarySearch.chop(5, [1,2,3,4,5,6,7,8,9]) == 4
  end
end
