defmodule ExpSay do
  @op_names %{
    +: {"add", "to"},
    -: {"subtract", "from"},
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
    {op_name, postfix} = @op_names[op]
    
    if op == :- or op == :+ do
      quote do
        "#{ExpSay.say(unquote(exp))} and #{unquote(op_name)} #{unquote(num)}"
      end
    else 
      quote do
        "#{ExpSay.say(unquote(exp))} and #{unquote(op_name)} #{unquote(postfix)} #{unquote(num)}"
      end
    end
  end

  defmacro say({op, _, [exp, num]}) when is_number(num) and is_tuple(exp) do
    {op_name, postfix} = @op_names[op]
    
    if op == :- or op == :+ do
      quote do
        "#{ExpSay.say(unquote(exp))} and #{unquote(op_name)} #{unquote(num)}"
      end
    else 
      quote do
        "#{ExpSay.say(unquote(exp))} and #{unquote(op_name)} #{unquote(postfix)} #{unquote(num)}"
      end
    end
  end

  defmacro say({op, _, [exp1, exp2]}) when is_tuple(exp1) and is_tuple(exp2) do
    {op_name, _} = @op_names[op]
  
    quote do
      "#{ExpSay.say(unquote(exp1))}, #{ExpSay.say(unquote(exp2))} and #{unquote(op_name)} them"
    end
  end
end
