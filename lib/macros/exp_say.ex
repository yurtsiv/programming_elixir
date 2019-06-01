defmodule ExpSay do
  @op_names %{
    +: {"add", "to"},
    -: {"substract", "from"},
    /: {"divide", "by"},
    *: {"multiply", "by"}
  }

  defmacro say({op, _, [num1, num2]}) when is_number(num1) and is_number(num2) do
    {op_name, postfix} = @op_names[op]

    quote do
      "#{unquote(op_name)} #{unquote(num1)} #{unquote(postfix)} #{unquote(num2)}"
    end
  end

  defmacro say({op, _, [num, exp]}) when is_number(num) and is_tuple(exp) do
  end
end
