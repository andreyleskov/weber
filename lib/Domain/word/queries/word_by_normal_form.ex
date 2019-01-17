defmodule Weber.Word.Queries.WordByNormalForm do
  import Ecto.Query

  alias Weber.Projection.WordRegister

  def new(normalForm) do
    from w in WordRegister,
    where: w.normalForm == ^normalForm
  end
end
