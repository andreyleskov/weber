defmodule Weber.Word.Queries.SynonymsByWord do
  import Ecto.Query

  alias Weber.Word.Projection.Synonym

  def new(word) do
    from s in Synonym,
    where: s.word == ^word
  end
end
