defmodule RingSupervisor do
  @name :ring

  def start do
    pid = spawn(__MODULE__, :main_loop, [nil, nil])
    :global.register_name(@name, pid)
  end

  def add_client do
    pid = RingClient.start()
    send(:global.whereis_name(@name), {:register, pid})
  end

  def main_loop(first_node, last_node) do
    receive do
      {:register, client} ->
        if first_node == nil and first_node == nil do
          send(client, {:register_next, client})
          send(client, {:receive})
          main_loop(client, client)
        else
          send(client, {:register_next, first_node})
          send(last_node, {:register_next, client})
          main_loop(client, last_node)
        end
    end
  end
end
