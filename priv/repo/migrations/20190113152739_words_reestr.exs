defmodule Weber.Repo.Migrations.WordsRegister do
  use Ecto.Migration

  def change do
    create table(:word_register) do
      add :normalForm, :string
      add :language, :string
    end
  end
end
