defmodule Weber.Word.Projection.Synonym do
  use Ecto.Schema

  schema "synonyms" do
    field :word, :string
    field :synonym, :string
  end
end
