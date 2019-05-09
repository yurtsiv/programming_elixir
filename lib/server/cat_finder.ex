defmodule CatFinder do
  def find_cats(parent) do
    send(parent, {:ready, self()})

    receive do
      {:ask, file_name, sender} ->
        occurences = find_cat_occurences(file_name) 
        send(sender, {:answer, file_name, occurences, self()})
        find_cats(parent)

      {:shutdown} ->
        exit(:normal)
    end
  end


  def find_cat_occurences(file_name) do
    File.read!(file_name)    
    |> String.split(" ")
    |> Enum.count(&(&1 === "cat"))
  end
end