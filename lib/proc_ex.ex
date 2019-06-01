defmodule Spawn2 do
  def run do
    receive do
      {sender, token} ->
        send(sender, {:ok, token})
    end
  end
end
