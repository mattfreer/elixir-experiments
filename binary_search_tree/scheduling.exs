# Problem: A runway reservation system

#Assume an airport with a single runway. There's obviously safety issues
#associated with landing planes, and planes taking off. And so there are
#constraints associated with the system, that have to be obeyed.

#So reservations for future landings is really what this system is built
#for. There's a notion of time. We'll assume that time is continuous. So
#it could be represented by a real variable, or a real quantity.

#And what we'd like to do is reserve requests for landings. And these are
#going to specify landing time. Each of them is going to specify a
#landing time.

#New requests for landing times need to be added to the schedule if no
#other landings are scheduled within x minutes

#We'd like to do all of these operations in order log n time, where n is
#the size of the set.

defmodule TreeNode do
  defstruct value: nil, left: nil, right: nil
end

defmodule RunwayReservationSystem do
  @interval 3

  def reserve(nil, time) do
    {:ok, %TreeNode{value: time}}
  end

  def reserve(%{value: value} = existing_node, time) do
    case valid?(time, value) do
      {:ok, _msg} -> add_to_schedule(existing_node, time)

      {:error, clash} ->
        {:error, reservation_clash_msg(time, clash)}
    end
  end

  defp add_to_schedule(%{value: value} = existing_node, time) do
    direction = insert_direction?(time, value)
    add_to_schedule(existing_node, time, direction)
  end

  defp add_to_schedule(%{right: right} = existing_node, time, :right) do
    reservation = reserve(right, time)
    insert(reservation, existing_node, :right)
  end

  defp add_to_schedule(%{left: left} = existing_node, time, :left) do
    reservation = reserve(left, time)
    insert(reservation, existing_node, :left)
  end

  defp insert_direction?(new_time, existing_time) do
    if new_time > existing_time do
      :right
    else
      :left
    end
  end

  defp insert({:error, _msg} = error, _existing_node, _direction) do
    error
  end

  defp insert({:ok, node}, %{value: value, left: left}, :right) do
    {:ok, %TreeNode{value: value, left: left, right: node}}
  end

  defp insert({:ok, node}, %{value: value, right: right}, :left) do
    {:ok, %TreeNode{value: value, left: node, right: right}}
  end

  defp valid?(a, b) do
    if abs((a - b)) >= @interval do
      {:ok, a}
    else
      {:error, b}
    end
  end

  defp reservation_clash_msg(time, clash) do
    "The proposed reservation (#{time}) clashes with an existing reservation (#{ clash })"
  end
end

ExUnit.start

defmodule RunwayReservationSystemTest do
  use ExUnit.Case

  test "inserting first item" do
    reservation = RunwayReservationSystem.reserve(nil, 5)
    assert {:ok, _node} = reservation
  end

  test "inserting valid item" do
    schedule = %TreeNode{
      value: 5,
      left: %TreeNode{value: 1},
      right: %TreeNode{value: 10}
    }
    reservation = RunwayReservationSystem.reserve(schedule, 14)
    assert {:ok, _node} = reservation
  end

  test "inserting invalid item" do
    schedule = %TreeNode{
      value: 5,
      left: %TreeNode{value: 1},
      right: %TreeNode{value: 10}
    }
    reservation = RunwayReservationSystem.reserve(schedule, 12)
    assert {:error, "The proposed reservation (12) clashes with an existing reservation (10)"} = reservation
  end
end
