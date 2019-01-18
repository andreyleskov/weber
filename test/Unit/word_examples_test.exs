defmodule Weber.Tests.Unit.Word.Examples do
  use ExUnit.Case

  @tag :unit
  @tag :word
  @tag :word_example
  test "Given word When providing examples Then examples provided event is raised" do
    assert   %Word.Events.ExamplesProvided{word: "fog", examples: "its a cloud"} ==
              Word.execute(%Word{word: "fog"},
                           %Word.Commands.ProvideExamples{word: "fog", examples: "its a cloud"})
  end

  @tag :unit
  @tag :word
  @tag :word_example
  test "Given word When apply example provided event Then description is changed" do

    assert %Word{word: "fog", examples: "like a cloud"} ==
           Word.apply(%Word{word: "fog"},  %Word.Events.ExamplesProvided{word: "fog", examples: "like a cloud"})

  end

  @tag :unit
  @tag :word
  @tag :word_example
  test "Given non-existing word When providing examples Then eror is raised" do
    catch_error  Word.execute(%Word{},
                 %Word.Commands.ProvideExamples{word: "fog", examples: "like a cloud"})
  end

end
