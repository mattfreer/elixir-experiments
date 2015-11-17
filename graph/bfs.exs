#Task: Find closest Male friend of John

#- Represent Graph in a Hash
#- Check friends closest first (BFS)
#- Use a Queue to check FIFO
#- Keep a check of whether we have already visited a person.

defmodule Queue do
  def create do
    []
  end

  def enqueue(queue, item) when is_list(item) do
    queue ++ item
  end

  def enqueue(queue, item) do
    enqueue(queue, [item])
  end
end

defmodule FriendUtils do
  def closest_male_friend?(graph, person) do
    [next_person|friends] = Queue.create |> Queue.enqueue(graph[person])
    bredth_first_search(graph, next_person, friends)
  end

  defp bredth_first_search(graph, person, queue, visited \\ [])

  defp bredth_first_search(_graph, person, [], _visited) do
    if is_male?(person) do
      person
    end
  end

  defp bredth_first_search(graph, person, queue, visited) do
    if is_male?(person) do
      person
    else
      if person in visited do
        bredth_first_search(graph, hd(queue), tl(queue))
      else
        visited = [person|visited]
        if has_friends?(graph, person) do
          queue = Queue.enqueue(queue, graph[person])
        end
        bredth_first_search(graph, hd(queue), tl(queue), visited)
      end
    end
  end

  # an overly simplified male check :)
  defp is_male?(person) do
    person in [:paul, :james, :john]
  end

  defp has_friends?(graph, person) do
    graph[person] != nil
  end
end

#---------------------------------------------------------

ExUnit.start

defmodule FriendUtilsTest do
  use ExUnit.Case

  setup do
    people = %{
      john: [:may, :joan, :shirley],
      may: [:debbie],
      joan: [:michelle, :joanne],
      shirley: [:vera, :joan],
      debbie: [:james],
      michelle: [:sue, :vera],
      sue: [:paul]
    }

    {:ok, people: people}
  end

  test :closest_male_friend?, %{people: people} do
    assert FriendUtils.closest_male_friend?(people, :john) == :james
    assert FriendUtils.closest_male_friend?(people, :michelle) == :paul
  end
end
