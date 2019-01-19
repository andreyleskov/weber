defmodule Weber.Word.Queries.TopWords do
  import Ecto.Query

  alias Weber.Projection.WordRegister

  def new() do
    from w in WordRegister, limit: 100
  end
end
