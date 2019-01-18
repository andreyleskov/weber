defmodule Weber.Tests.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Commanded.Assertions.EventAssertions
    end
  end

  setup do
    Weber.Tests.Storage.reset!()
    :ok
  end
end
