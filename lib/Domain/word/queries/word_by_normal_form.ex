defmodule Weber.Word.Queries.WordByNormalForm do
  import Ecto.Query

  alias Weber.Projection.WordRegister

  def new(word) do
    from w in WordRegister,
    where: w.word == ^word
  end
end
