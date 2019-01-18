defmodule Weber.Repo.Migrations.WordsRegister do
  use Ecto.Migration

  def change do
    create table(:word_register, primary_key: false) do
      add :normalForm, :string, primary_key: true
      add :language, :string
    end
  end
end
