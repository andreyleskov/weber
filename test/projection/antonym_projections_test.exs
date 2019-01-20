defmodule Weber.Tests.Projection.Antonym do
  use ExUnit.Case
  use Weber.Tests.DataCase
  import Commanded.Assertions.EventAssertions

  @tag :projection
  @tag :antonym
  test "Given a word And add antonym command When executing Then receive event And has antonym projection created" do


    :ok = Weber.Router.dispatch(%Word.Commands.Create{word: "run", description: "En"}, consistency: :strong)
    :ok = Weber.Router.dispatch(%Word.Commands.AddAntonym{word: "run", antonym: "stop"}, consistency: :strong)

    expectedEvent = %Word.Events.AntonymAdded{word: "run", antonym: "stop"}

    assert_receive_event(Word.Events.AntonymAdded, fn event ->
      assert event == expectedEvent
    end)

    antonymProjection = Weber.Word.Queries.AntonymsByWord.new("run") |>
                        Weber.Projection.Repo.one()

    assert antonymProjection.word == "run"
    assert antonymProjection.antonym == "stop"

  end

end
