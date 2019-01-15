defmodule Weber.Projection.WordRegister do
  use Ecto.Schema

  schema "word_register" do
    field :normalForm, :string
    field :language, :string
  end
end
