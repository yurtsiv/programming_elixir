defmodule MyList do
  def map([], _fun), do: []
  def map([head | tail], fun), do: [fun.(head) | map(tail, fun)]

  def sum([el]), do: el

  def sum([head | tail]), do: head + sum(tail)

  def mapsum(list, func) do
    list
    |> map(func)
    |> sum()
  end

  def reduce([], value, _), do: value

  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def max(list) do
    reduce(list, hd(list), &max/2)
  end

  def ceasar(str, offset) do
    str
    |> map(&(&1 + offset))
  end

  def span(to, to), do: []

  def span(from, to) do
    [from] ++ span(from + 1, to)
  end

  def orders(tax, ords) do
    for {state, tax} <- tax, order <- ords do
      if state == order[:ship_to] do
        Keyword.put(order, :total_amount, order[:net_amount] + tax)
      else
        order
      end
    end

  end
end
