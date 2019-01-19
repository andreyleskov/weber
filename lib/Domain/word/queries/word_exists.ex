defmodule Weber.Word.Queries.WordExists do
  import Ecto.Query

  alias Weber.Projection.WordRegister

  def new(word) do
    from w in WordRegister,
    where: w.normalForm == ^word,
    select: %{normalForm: w.normalForm}
  end
end
