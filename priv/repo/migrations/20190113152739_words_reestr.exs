defmodule Weber.Repo.Migrations.WordsReestr do
  use Ecto.Migration

  def change do
    create table(:word_register) do
      add :normal_form, :string
      add :language, :string
    end
  end
end
