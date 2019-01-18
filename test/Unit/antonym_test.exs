defmodule Weber.Tests.Unit.Antonym do
  use ExUnit.Case
  @tag :unit
  @tag :antonym
  test "antonym cannot be added to non-existing world" do
   catch_error Word.execute(%Word{}, %Word.Commands.AddAntonym{word: "notExist", antonym: "pizza"})
  end

  @tag :unit
  @tag :antonym
  test "antonym can be added to a word" do
    assert %Word.Events.AntonymAdded{word: "dish", antonym: "pizza"} ==
        Word.execute(%Word{word: "dish"}, %Word.Commands.AddAntonym{word: "dish", antonym: "pizza"})
  end

  @tag :unit
  @tag :antonym
  test "Given antonym added When appled Then antonym is stored in aggregate" do
    newState =  Word.apply(%Word{word: "dish"},  %Word.Events.AntonymAdded{word: "dish", antonym: "pizza"})
    assert %Word{word: "dish", antonyms: ["pizza"]} == newState

  end

  @tag :unit
  @tag :antonym
  test "antonym cannot be added to notmatched world" do
   catch_error Word.execute(%Word{word: "word"}, %Word.Commands.AddAntonym{word: "wrongWord", antonym: "pizza"})
  end

  @tag :unit
  @tag :antonym
  test "antonym cannot be added twice to the same word" do
    word = %Word{word: "dish"}
    command = %Word.Commands.AddAntonym{word: "dish", antonym: "pizza"}

    events = Word.execute(word, command)
    IO.puts(inspect(events))

    wordWithAntonym = Word.apply(word, events)

    assert {:error, :dublicated_antonym}
        == Word.execute(wordWithAntonym, command)
  end

end
