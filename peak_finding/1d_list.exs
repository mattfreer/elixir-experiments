# A peak is any element that is larger or equal to both it's neighbours
# Items that only have one neighbour (end items) are considered a peak if
#they are larger or equal to their neighbour

# This algorithm only finds a single peak.

defmodule PeakFinder do
  def find(list) do
    middle = round((length(list) - 1) / 2)
    find(list, middle)
  end

  def find([], _index) do
    -1
  end

  # furthest item right
  def find(list, index) when index == (length(list) - 1) do
    value = Enum.at(list, index)

    if peak?(value, left_item(list, index)) do
      value
    else
      -1
    end
  end

  # furthest item left
  def find(list, index) when index == 0 do
    value = Enum.at(list, index)

    if peak?(value, right_item(list, index)) do
      value
    else
      -1
    end
  end

  def find(list, index) do
    value = Enum.at(list, index)
    left = left_item(list, index)
    right = right_item(list, index)

    if peak?(value, left, right) do
      value
    else
      if left.value > value do
        find(list, left.index)
      else
        find(list, right.index)
      end
    end
  end

  defp peak?(value, %{value: comparator}) do
    (value >= comparator)
  end

  defp peak?(value, %{value: left}, %{value: right}) do
    (value >= left && value >= right)
  end

  defp left_item(list, index) do
    item(list, index - 1)
  end

  defp right_item(list, index) do
    item(list, index + 1)
  end

  defp item(list, index) do
    %{
      index: index,
      value: Enum.at(list, index)
    }
  end
end

ExUnit.start

defmodule PeakFinderTest do
  use ExUnit.Case

  test :find do
    assert PeakFinder.find([3,2,4,7,5,6,2]) in [7]
    assert PeakFinder.find([3,2,1]) in [3]
    assert PeakFinder.find([3,2,4,3,5,6,2]) in [3,4,6]
    assert PeakFinder.find([3,2,0,1,2,6,2]) in [3,6]
    assert PeakFinder.find([3,2,1,4]) in [3,4]
    assert PeakFinder.find([1,3,2,1]) in [3]
    assert PeakFinder.find([3,3,2,2]) in [2,3]
  end
end
