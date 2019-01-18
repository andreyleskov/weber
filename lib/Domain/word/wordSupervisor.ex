defmodule Weber.Word.Supervisor do
  use Supervisor
  alias Weber.Projector
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Projector.WordRegister,
      Weber.Word.Projections.Synonym.Projector,
      Weber.Word.Projections.Antonym.Projector
    ], strategy: :one_for_one)
  end
end
