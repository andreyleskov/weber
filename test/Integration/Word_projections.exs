defmodule WordTest do
  #use Weber.DataCase
  use ExUnit.Case
  @tag unit
  test "Given a create new word command When executing Then has word registry projected" do

    assert Word.execute(%Word{}, %Word.Commands.Create{normalForm: "testMe", language: "En"}) ==
        %Word.Events.Created{normalForm: "testMe", language: "En"}

  end

  test "check created apply" do
    assert Word.apply(%Word{}, %Word.Events.Created{normalForm: "testMe", language: "En"}) ==
      %Word{normalForm: "testMe", language: "En"}
  end

end
