defmodule NodeItem do
  defstruct value: nil, next: nil

  def create(value, next \\ :null) do
    %NodeItem{
      value: value,
      next: next
    }
  end
end

defmodule LinkedListUtils do
  def is_cyclic?(list, visited \\ [])

  def is_cyclic?(list=[], visited) do
    false
  end

  def is_cyclic?([head|tail], visited) do
    if Enum.member?(visited, head.next) do
      true
    else
      visited = [head|visited]
      is_cyclic?(tail, visited)
    end
  end
end

#------------------------------------------------

ExUnit.start

defmodule LinkedListUtilsTest do
  use ExUnit.Case

  test :is_cyclic? do
    d = NodeItem.create(4)
    c = NodeItem.create(3, d)
    b = NodeItem.create(2, c)
    a = NodeItem.create(1, b)
    d = %{d|next: a}

    list = [a,b,c,d]
    assert LinkedListUtils.is_cyclic?(list) == true
  end

  test :is_cyclic? do
    d = NodeItem.create(4)
    c = NodeItem.create(3, d)
    b = NodeItem.create(2, c)
    a = NodeItem.create(1, b)

    list = [a,b,c,d]
    assert LinkedListUtils.is_cyclic?(list) == false
  end
end
