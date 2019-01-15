defmodule Weber.DataCase do
  use ExUnit.CaseTemplate
  alias Weber.Application

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Commanded.Assertions.EventAssertions
    end
  end

  setup do
   # {:ok, _} = Application.ensure_all_started(:weber)

    on_exit(fn ->
      :ok = Application.stop(:weber)
      :ok = Application.stop(:commanded)
      :ok = Application.stop(:eventstore)

      Application.Storage.reset!()
    end)

    :ok
  end
end
