defmodule Weber.Tests.Projection.Synonym do
  use ExUnit.Case
  use Weber.Tests.DataCase
  import Commanded.Assertions.EventAssertions
  alias Weber.Word.Queries.WordByNormalForm

  @tag :projection
  @tag :synonym
  test "Given a word And add synonym command When executing Then receive event And has synonyms projection created" do


    :ok = Weber.Router.dispatch(%Word.Commands.Create{word: "run", language: "En"}, consistency: :strong)
    :ok = Weber.Router.dispatch(%Word.Commands.AddSynonym{word: "run", synonym: "dash"}, consistency: :strong)

    expectedEvent = %Word.Events.SynonymAdded{word: "run", synonym: "dash"}

    assert_receive_event(Word.Events.SynonymAdded, fn event ->
      assert event == expectedEvent
    end)

   # :timer.sleep(1000);

    synonymProjection = Weber.Word.Queries.SynonymsByWord.new("run") |>
                        Weber.Projection.Repo.one()

    assert wordProjection =
       %Weber.Word.Projection.Synonym{word: "run", synonym: "dash"}

  end
end
