defmodule Chop do
  def guess(_, a..b) when a === b, do: a

  def guess(actual, a..b) do
    half = a + div(b - a, 2)

    IO.puts("Is it #{half}")

    cond do
      half > actual ->
        guess(actual, a..half)

      half < actual ->
        guess(actual, half..b)

      true ->
        IO.puts("THE END #{half}")
    end
  end
end
