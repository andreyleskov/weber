defmodule Weber.Tests.Unit.Synonym do
  use ExUnit.Case
  @tag :unit
  @tag :synonym
  test "synonym cannot be added to non-existing world" do
   catch_error Word.execute(%Word{}, %Word.Commands.AddSynonym{word: "notExist", synonym: "pizza"})
  end

  @tag :unit
  @tag :synonym
  test "synonym can be added to a word" do
    assert %Word.Events.SynonymAdded{word: "dish", synonym: "pizza"} ==
        Word.execute(%Word{word: "dish"}, %Word.Commands.AddSynonym{word: "dish", synonym: "pizza"})
  end

  @tag :unit
  @tag :synonym
  test "Given synonym added When appled Then synonym is stored in aggregate" do
    newState =  Word.apply(%Word{word: "dish"},  %Word.Events.SynonymAdded{word: "dish", synonym: "pizza"})
    assert %Word{word: "dish", synonyms: ["pizza"]} == newState

  end

  @tag :unit
  @tag :synonym
  test "synonym cannot be added to notmatched world" do
   catch_error Word.execute(%Word{word: "word"}, %Word.Commands.AddSynonym{word: "wrongWord", synonym: "pizza"})
  end

  @tag :unit
  @tag :synonym
  test "synonym cannot be added twice to the same word" do
    word = %Word{word: "dish"}
    command = %Word.Commands.AddSynonym{word: "dish", synonym: "pizza"}

    events = Word.execute(word, command)
    IO.puts(inspect(events))

    wordWithSynonym = Word.apply(word, events)

    assert {:error, :dublicated_synonym}
        == Word.execute(wordWithSynonym, command)
  end

end
