defmodule Weber.Tests.Projection.LookupHistory do
  use ExUnit.Case
  use Weber.Tests.DataCase
  import Commanded.Assertions.EventAssertions

  @tag :projection
  @tag :lookup
  test "Given a word lookup When executing Then receive event And has history projection created" do

    :ok = Weber.Router.dispatch(%Lookup.Commands.ShowWord{word: "run"}, consistency: :strong)

    assert_receive_event(Lookup.Events.WordShown, fn event ->
      assert event == %Lookup.Events.WordShown{word: "run", views: 1}
    end)

    :ok = Weber.Router.dispatch(%Lookup.Commands.ShowWord{word: "run"}, consistency: :strong)
    :ok = Weber.Router.dispatch(%Lookup.Commands.ShowWord{word: "run"}, consistency: :strong)

    lookupHistory = Weber.Lookup.Queries.TotalViews.new("run") |>
                        Weber.Projection.Repo.one()

    assert lookupHistory.word == "run"
    assert lookupHistory.total_views == 3
  end
end
