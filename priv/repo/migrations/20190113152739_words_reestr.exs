defmodule Weber.Repo.Migrations.WordsRegister do
  use Ecto.Migration

  def change do
    create table(:word_register, primary_key: false) do
      add :normalForm, :string, primary_key: true
      add :description, :text
      add :examples, :text
      add :illustration_binary, :binary
      add :illustration_extension, :string
    end
  end
end
