defmodule Test do
  require My

  local = 123

  My.local_update("hello")

  IO.puts("Local end: #{local}")

  def run do
  end
end
