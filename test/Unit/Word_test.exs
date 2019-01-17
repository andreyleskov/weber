defmodule Weber.Tests.Unit.Word do
  use ExUnit.Case
  @tag :unit
  @tag :word
  test "word can be created" do

    assert Word.execute(%Word{}, %Word.Commands.Create{word: "testMe", language: "En"}) ==
        %Word.Events.Created{word: "testMe", language: "En"}

  end

  @tag :unit
  @tag :word
  test "Given word created When applied Then word normal form is set" do
    assert Word.apply(%Word{}, %Word.Events.Created{word: "testMe", language: "En"}) ==
      %Word{word: "testMe", language: "En"}
  end

end
