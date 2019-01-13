defmodule Weber.WordRegister do
  use Ecto.Schema

  schema "wordRegister" do
    field :normalForm, :string
    field :language, :string
  end
end
