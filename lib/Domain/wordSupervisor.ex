defmodule Weber.Word.Supervisor do
  use Supervisor
  alias Weber.Word
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init([
      Word.Projector.Register
    ], strategy: :one_for_one)
  end
end
