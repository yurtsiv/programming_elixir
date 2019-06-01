defmodule Parallel do
  def pmap(list, func) do
    me = self()

    list
    |> Enum.map(fn item ->
      spawn(fn -> send(me, {self(), func.(item)}) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {_pid, result} -> result
      end
    end)
  end
end
