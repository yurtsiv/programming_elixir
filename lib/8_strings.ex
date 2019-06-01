defmodule Strings do
  def only_ascii?(str) do
    Enum.all?(&(&1 >= 26 and &1 <= 126))
  end

  def anagram(word1, word2) do
    if length(Enum.uniq(word1)) !== length(Enum.uniq(word2)) do
      false
    else
      Enum.all?(word1, &Enum.member?(word2, &1))
    end
  end

  def evaluate(expression) do
    [first_num_str, operator, second_num_str] =
      expression
      |> to_string
      |> String.split(" ")

    {first_num, _} = Integer.parse(first_num_str)
    {second_num, _} = Integer.parse(second_num_str)

    case operator do
      "+" -> first_num + second_num
      "-" -> first_num - second_num
      "*" -> first_num * second_num
      "/" -> first_num / second_num
    end
  end
end
