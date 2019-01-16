defmodule Weber.Tests.Integration.WordProjection do
  use ExUnit.Case
  use Weber.Tests.DataCase
  import Commanded.Assertions.EventAssertions


  @tag :integration
  test "Given a create new word command When executing Then receive event And has word registry created" do
    expectedEvent = %Word.Events.Created{normalForm: "testMe", language: "En"}

    :ok = Weber.Router.dispatch(%Word.Commands.Create{normalForm: "testMe", language: "En"})
    assert_receive_event(Word.Events.Created, fn event ->
      assert event == expectedEvent
    end)


  end
end
