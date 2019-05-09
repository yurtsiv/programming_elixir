defmodule My do
  defmacro macro(param) do
    quote do: IO.puts "hello"
  end

  defmacro local_update(val) do
    local = "SOME VAL"

    result = quote do
      local = unquote(val)
      IO.puts "Local in macro: #{local}"
    end

    IO.puts "Local in func: #{local}"

    result
  end

  defmacro mydef(name) do
    quote bind_quoted: [name: name] do
      def unquote(name)() do
        unquote(name)
      end
    end
  end

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        true -> unquote(else_clause) 
        _ -> unquote(do_clause)
      end
    end
  end

  defmacro times_n(n) do
    quote  do
      def unquote(:"times_#{n}")(times) do
        unquote(n) + times
      end
    end
  end
end