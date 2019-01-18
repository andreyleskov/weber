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

  @tag :unit
  @tag :word
  @tag :word_describe
  test "Given word When describing Then described event is raised" do

    assert   %Word.Events.Described{word: "fog", description: "like a cloud"} ==
              Word.execute(%Word{word: "fog"},
                           %Word.Commands.Describe{word: "fog", description: "like a cloud"})
  end

  @tag :unit
  @tag :word
  @tag :word_describe
  test "Given word When apply described event Then description is changed" do

    assert %Word{word: "fog", description: "like a cloud"} ==
           Word.apply(%Word{word: "fog"},  %Word.Events.Described{word: "fog", description: "like a cloud"})

  end

  @tag :unit
  @tag :word
  @tag :word_describe
  test "Given non-existing word When describing Then eror is raised" do
    catch_error  Word.execute(%Word{},
                 %Word.Commands.Describe{word: "fog", description: "like a cloud"})
  end

end
