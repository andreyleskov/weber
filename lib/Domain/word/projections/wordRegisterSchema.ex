defmodule Weber.Projection.WordRegister do
  use Ecto.Schema

  @primary_key {:normalForm, :string, autogenerate: false}
  schema "word_register" do
    field :description, :string
    field :examples, :string
    field :illustration_binary, :binary
    field :illustration_extension, :string
  end
end
