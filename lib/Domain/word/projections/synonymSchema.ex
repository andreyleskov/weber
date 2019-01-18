defmodule Weber.Word.Projection.Synonym do
  use Ecto.Schema

  @primary_key {:word, :string, autogenerate: false}
  schema "synonyms" do
    field :synonym, :string, primary_key: true
  end
end
