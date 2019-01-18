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

  @tag :integration
  @tag :word_description
  @tag :doMe
  test "Given a word AND update description command When executing Then receive event And description updated" do
    :ok = Weber.Router.dispatch(%Word.Commands.Create{word: "best", description: "none"}, consistency: :strong)
    :ok = Weber.Router.dispatch(%Word.Commands.Describe{word: "best", description: "of the best"}, consistency: :strong)

    assert_receive_event(Word.Events.Described, fn event ->
      assert event == %Word.Events.Described{word: "best", description: "of the best"}
    end)

    wordProjection = WordByNormalForm.new("best") |>
                     Weber.Projection.Repo.one()

    assert wordProjection.normalForm == "best"
    assert wordProjection.description == "of the best"
  end

  @tag :integration
  @tag :word_examples
  test "Given a word AND provide examples command When executing Then receive event And examples updated" do
    :ok = Weber.Router.dispatch(%Word.Commands.Create{word: "best"}, consistency: :strong)
    :ok = Weber.Router.dispatch(%Word.Commands.ProvideExamples{word: "best", examples: "best of the best"}, consistency: :strong)

    assert_receive_event(Word.Events.ExamplesProvided, fn event ->
      assert event == %Word.Events.ExamplesProvided{word: "best", examples: "best of the best"}
    end)

    wordProjection = WordByNormalForm.new("best") |>
                     Weber.Projection.Repo.one()

    assert wordProjection.normalForm == "best"
    assert wordProjection.examples == "best of the best"
  end

end
