defmodule Weber.Lookup.Supervisor do
  use Supervisor
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Weber.Lookup.Projections.LookupHistory,
    ], strategy: :one_for_one)
  end
end
