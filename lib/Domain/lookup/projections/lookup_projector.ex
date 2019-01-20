defmodule Weber.Lookup.Projections.LookupHistory do
  use Commanded.Projections.Ecto,
      name: "Weber.LookupHistory",
      consistency: :strong

  project %Lookup.Events.WordShown{word: word, views: views} do
    occured_at = DateTime.truncate(DateTime.utc_now(), :second)

    Ecto.Multi.insert(multi,
                      :lookup_history,
    %Weber.Lookup.Projection.LookupHistory{word: word,
                                           occured_at: occured_at,
                                           total_views: views})
  end
end
