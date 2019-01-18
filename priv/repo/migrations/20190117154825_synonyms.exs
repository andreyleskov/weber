defmodule Weber.Projection.Repo.Migrations.Synonyms do
  use Ecto.Migration

  def change do
    create table(:synonyms, primary_key: false) do
      add :word, :string, primary_key: true
      add :synonym, :string, primary_key: true
    end
  end
end
