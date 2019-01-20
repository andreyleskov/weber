defmodule Weber.Lookup.Queries.TotalViews do
  import Ecto.Query

  alias Weber.Lookup.Projection.LookupHistory

  def new(word) do
    from h in LookupHistory,
    limit: 1,
    where: h.word == ^word,
    order_by: [desc: h.occured_at, desc: h.total_views]
  end
end
