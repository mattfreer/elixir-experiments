defmodule Tree.Node do
  defstruct value: nil, left: nil, right: nil
end

defmodule Tree.Traversal do
  def preorder(nil) do
    []
  end

  def preorder(%Tree.Node{value: value, left: left, right: right}) do
    [value] ++ preorder(left) ++ preorder(right)
  end

  def postorder(%Tree.Node{value: value, left: left, right: right}) do
    preorder(left) ++ preorder(right) ++ [value]
  end

  def inorder(%Tree.Node{value: value, left: left, right: right}) do
    preorder(left) ++ [value] ++ preorder(right)
  end
end


ExUnit.start

defmodule TreeTraversalTest do
  use ExUnit.Case

  alias Tree.Node

  setup do
    tree = %Node{
      value: "Book",

      left: %Node{
        value: "Chapter 1",
        left: %Node{
          value: "Section 1.1",
        },

        right: %Node{
          value: "Section 1.2",

          left: %Node{
            value: "Section 1.2.1"
          },

          right: %Node{
            value: "Section 1.2.2",
          }
        }
      },

      right: %Node{
        value: "Chapter 2",

        left: %Node{
          value: "Section 2.1"
        },

        right: %Node{
          value: "Section 2.2",
          left: %Node{
            value: "Section 2.2.1"
          },
          right: %Node{
            value: "Section 2.2.2"
          }
        }
      }
    }

    {:ok, tree: tree}
  end


  test "preorder traversal", %{tree: tree} do
    assert Tree.Traversal.preorder(tree) == [
      "Book",
      "Chapter 1",
      "Section 1.1",
      "Section 1.2",
      "Section 1.2.1",
      "Section 1.2.2",
      "Chapter 2",
      "Section 2.1",
      "Section 2.2",
      "Section 2.2.1",
      "Section 2.2.2"
    ]
  end

  test "postorder traversal", %{tree: tree} do
    assert Tree.Traversal.postorder(tree) == [
      "Chapter 1",
      "Section 1.1",
      "Section 1.2",
      "Section 1.2.1",
      "Section 1.2.2",
      "Chapter 2",
      "Section 2.1",
      "Section 2.2",
      "Section 2.2.1",
      "Section 2.2.2",
      "Book"
    ]
  end

  test "inorder traversal", %{tree: tree} do
    assert Tree.Traversal.inorder(tree) == [
      "Chapter 1",
      "Section 1.1",
      "Section 1.2",
      "Section 1.2.1",
      "Section 1.2.2",
      "Book",
      "Chapter 2",
      "Section 2.1",
      "Section 2.2",
      "Section 2.2.1",
      "Section 2.2.2"
    ]
  end
end
