defmodule MyEnum do
  def all?([], _func), do: true

  def all?([head | tail], func) do
    if not func.(head) do
      false
    else
      all?(tail, func)
    end
  end

  def each([], _func), do: :ok

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []

  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def flatten([]), do: []

  def flatten(list) do
    Enum.reduce(
      list,
      [],
      fn x, acc ->
        cond do
          is_list(x) ->
            acc ++ flatten(x)

          true ->
            [x | acc]
        end
      end
    )
  end
end
