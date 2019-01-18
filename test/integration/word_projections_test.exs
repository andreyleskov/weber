defmodule Weber.Tests.Integration.WordProjection do
  use ExUnit.Case
  use Weber.Tests.DataCase
  import Commanded.Assertions.EventAssertions
  alias Weber.Word.Queries.WordByNormalForm

  @tag :integration
  @tag :word
  test "Given a create new word command When executing Then receive event And has word registry created" do
    expectedEvent = %Word.Events.Created{word: "testMe", description: "En"}

    :ok = Weber.Router.dispatch(%Word.Commands.Create{word: "testMe", description: "En"}, consistency: :strong)

    assert_receive_event(Word.Events.Created, fn event ->
      assert event == expectedEvent
    end)

    wordProjection = WordByNormalForm.new("testMe") |>
                     Weber.Projection.Repo.one()

    assert wordProjection =
       %Weber.Projection.WordRegister{normalForm: "testMe", description: "En"}

  end
end
