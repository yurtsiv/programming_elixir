defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
        exit(:boom)
    end
  end
end