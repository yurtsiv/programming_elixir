defmodule Tracer do
  import IO.ANSI

  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  def print_call(name, args) do
    # Question: Why does passing a list of strings to IO.puts work?
    # Answer: because IO.puts can take iolist which is a list of binaries(strings) or other iolists etc.
    IO.puts([
      white(),
      green_background(),
      "==> call",
      reset(),
      ": #{Tracer.dump_defn(name, args)}"
    ])
  end

  defmacro def(definition, do: content) do
    # Question: Try adding a method definition with a guard clause to the Test module. You’ll find that the tracing no longer works.
    #   – Find out why.
    #   – See if you can fix it
    # Answer: It didn't work because definitions with guards have a special form that needs to be pattern matched on separately.

    {name, args} =
      case definition do
        {:when, _, [{name, _, args}, _]} -> {name, args}
        {name, _, args} -> {name, args}
      end

    quote do
      Kernel.def unquote(definition) do
        Tracer.print_call(unquote(name), unquote(args))
        result = unquote(content)

        # Question: Why does the first call to puts have to unquote the values in its interpolation but the second call does not?
        # Answer: because 'name'/'args' are quoted and 'result' is a computed value
        IO.puts("<== result: #{result}")
        result
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer

  def puts_sum_three(a,b,c), do: IO.inspect(a+b+c)
  def add_list(list), do: Enum.reduce(list, 0, &(&1+&2))

  def guarded(num) when num > 0, do: num + 10
  def guarded(num), do: num
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])
Test.guarded(1)
