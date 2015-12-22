defmodule FindWithRecursion do

  def find_duplicate(list \\ [], acc \\ [])

  def find_duplicate([], acc) do
    nil
  end

  @spec find_duplicate(list) :: integer
  def find_duplicate([head|tail], acc) do
    if Enum.member?(acc, head) do
      head
    else
      acc = [head|acc]
      find_duplicate(tail, acc)
    end
  end
end

defmodule FindWithMath do
  def find_duplicate(list) do

    control_list = 1..(length(list) -1)
    Enum.sum(list) - Enum.sum(control_list)
  end
end

#FindWithRecursion.find_duplicate([1,2,3,2,4,5])
FindWithMath.find_duplicate([1,2,3,3,4,5])
