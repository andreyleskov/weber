defmodule Weber.Tests.Unit.Word.Illustration do
  use ExUnit.Case

  @tag :unit
  @tag :word
  @tag :illustration
  test "Given word When illustrating Then illustrated event is raised" do
    assert   %Word.Events.Illustrated{word: "fog", illustration: %Word.Image{base64: "12AD", extension: "none"}} ==
              Word.execute(%Word{word: "fog"},
                           %Word.Commands.Illustrate{word: "fog", illustration: %Word.Image{base64: "12AD", extension: "none"}})
  end

  @tag :unit
  @tag :word
  @tag :illustration
  test "Given word When apply illustrated event Then illustration is changed" do
    illustration =  %Word.Image{base64: "1", extension: "none"}
    assert %Word{word: "fog", illustration: illustration} ==
           Word.apply(%Word{word: "fog"},  %Word.Events.Illustrated{word: "fog", illustration: illustration})

  end

  @tag :unit
  @tag :word
  @tag :illustration
  test "Given non-existing word When illustrating Then eror is raised" do
    catch_error  Word.execute(%Word{},
                 %Word.Commands.Illustrate{word: "fog", illustration: %Word.Image{base64: "1AD", extension: "none"}})
  end

end
