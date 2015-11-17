defmodule TreeNode do
  defstruct value: nil, left: nil, right: nil
end

defmodule BinarySearchTree do

  def add_node(nil, new_value) do
    %TreeNode{value: new_value}
  end

  def add_node(%{value: value, left: left, right: right} = existing_node, new_value) do
    direction = direction?(new_value, value)
    insert(existing_node, new_value, direction)
  end

  def largest?(%{value: value, right: right = nil}) do
    value
  end

  def largest?(node) do
    largest?(node.right)
  end

  defp direction?(new_value, existing_value) do
    if new_value < existing_value do
      :left
    else
      :right
    end
  end

  defp insert(%{value: value, left: left, right: right}, new_value, :left) do
    %TreeNode{value: value, left: add_node(left, new_value), right: right}
  end

  defp insert(%{value: value, left: left, right: right}, new_value, :right) do
    %TreeNode{value: value, left: left, right: add_node(right, new_value)}
  end
end

ExUnit.start

defmodule BinarySearchTreeTest do
  use ExUnit.Case

  test :largest? do
    node = Enum.reduce([5,3,1,4,8,7,12,10,9,11], nil, fn (item, acc) ->
      BinarySearchTree.add_node(acc, item)
    end)

    assert BinarySearchTree.largest?(node) == 12
  end
end
