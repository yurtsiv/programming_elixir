defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_num) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_num]);

    start_workers(sup, initial_num)

    result
  end

  def start_workers(sup, initial_num) do
    {:ok, stash} =
      Supervisor.start_child(sup, worker(Sequence.Stash, [initial_num]))

    res = Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
    IO.inspect res
  end


  def init(_) do
    supervise [], strategy: :one_for_one
  end
end