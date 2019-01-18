defmodule Weber.Word.Queries.AntonymsByWord do
  import Ecto.Query

  alias Weber.Word.Projection.Antonym

  def new(word) do
    from s in Antonym,
    where: s.word == ^word
  end
end
