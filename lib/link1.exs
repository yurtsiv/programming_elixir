defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)

    exit(:boom)
  end

  def run do
    res = spawn_monitor(Link1, :sad_function, [])
    IO.inspect res

    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect(msg)}"

      after 1000 ->
        IO.puts("Nothing happened")
    end
  end
end
