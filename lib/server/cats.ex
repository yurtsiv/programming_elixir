defmodule Cats do
  def run do
    to_process = File.ls!() |> Enum.filter(&String.contains?(&1, "."))

    Enum.each 1..100, fn num_processes ->
      {time, result} = :timer.tc(Scheduler, :run,
      [num_processes, CatFinder, :find_cats, to_process])
    
      if num_processes == 1 do
        IO.puts inspect result
        IO.puts "\n # time (s)"
      end
    
      :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
    end
  end
end