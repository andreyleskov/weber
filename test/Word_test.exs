defmodule WordTest do
  use ExUnit.Case
  #use Word
  #use Word.Commands
  #use Word.Events

  #doctest WordTest

  test "creates the world" do
    assert Word.execute(%Word{}, %Word.Commands.Create{normalForm: "testMe", language: "En"}) ==
        %Word.Events.Created{normalForm: "testMe", language: "En"}
  end

end
