defmodule Weber.Lookup.Projection.LookupHistory do
  use Ecto.Schema

  @primary_key {:word, :string, autogenerate: false}
  schema "lookup_history" do
    field :occured_at, :utc_datetime
    field :total_views, :integer, primary_key: true
  end
end
