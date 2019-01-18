defmodule Weber.Word.Projection.Antonym do
  use Ecto.Schema

  @primary_key {:word, :string, autogenerate: false}
  schema "antonyms" do
    field :antonym, :string, primary_key: true
  end
end
