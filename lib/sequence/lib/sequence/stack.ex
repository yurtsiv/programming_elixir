defmodule Stack do
  use GenServer

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value | state]}
  end
end