defmodule Weber.Projection.WordRegister do
  use Ecto.Schema

  @primary_key {:normalForm, :string, autogenerate: false}
  schema "word_register" do
    field :description, :string
    field :examples, :string
  end
end
