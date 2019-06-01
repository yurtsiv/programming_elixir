defmodule NodeClient do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    NodeTicker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("Tick received")
        receiver()
    end
  end
end
