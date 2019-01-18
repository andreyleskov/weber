defmodule Weber.Projection.Repo.Migrations.Antonyms do
  use Ecto.Migration

  def change do
    create table(:antonyms, primary_key: false) do
      add :word, :string, primary_key: true
      add :antonym, :string, primary_key: true
    end
  end
end
