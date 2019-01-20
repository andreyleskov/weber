defmodule Weber.Projection.Repo.Migrations.AddLookup do
  use Ecto.Migration

  def change do
    create table(:lookup_history, primary_key: false) do
      add :word, :string, primary_key: true
      add :occured_at, :utc_datetime
      add :total_views, :integer, primary_key: true
    end
    create index(:lookup_history, [:word, :occured_at])
  end
end
