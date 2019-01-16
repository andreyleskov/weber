defmodule Weber.Tests.Unit.Word do
  use ExUnit.Case
  @tag :unit
  test "creates the world" do

    assert Word.execute(%Word{}, %Word.Commands.Create{normalForm: "testMe", language: "En"}) ==
        %Word.Events.Created{normalForm: "testMe", language: "En"}

  end

  @tag :unit
  test "check created apply" do
    assert Word.apply(%Word{}, %Word.Events.Created{normalForm: "testMe", language: "En"}) ==
      %Word{normalForm: "testMe", language: "En"}
  end

end
