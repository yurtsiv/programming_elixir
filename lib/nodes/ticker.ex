defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def generator(clients, queue) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        generator([pid | clients], [pid | queue])
    after
      @interval ->
        IO.puts("Server: tick")

        case {clients, queue} do
          {[], []} ->
            generator([], [])

          {_, []} ->
            send(hd(clients), {:tick})
            generator(clients, tl(clients))

          {_, _} ->
            send(hd(queue), {:tick})
            generator(clients, tl(queue))
        end
    end
  end
end
