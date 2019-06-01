defmodule Times do
  def double(n), do: n * n

  def tripple(n), do: n * n * n

  def qudruple(n), do: double(n) * double(n)
end
