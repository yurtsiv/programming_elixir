defmodule RingClient do
  def start do
    spawn(__MODULE__, :listen, [nil])
  end

  def listen(next_client) do
    receive do
      {:register_next, next} ->
        listen(next)
      {:receive} when next_client !== nil ->
        IO.puts("#{inspect self()}: Tock")
        :timer.sleep(2000)
        IO.puts("#{inspect self()}: Tick")
        send(next_client, {:receive})
        listen(next_client)
    end
  end
end