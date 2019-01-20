defmodule Weber.Tests.Unit.Lookup do
  use ExUnit.Case


  @tag :unit
  @tag :lookup
  test "Given word shown When applied Then views are taken from event" do
    assert Lookup.apply(%Lookup{}, %Lookup.Events.WordShown{word: "testMe", views: 10}) ==
          %Lookup{word: "testMe", views: 10}
  end

  @tag :unit
  @tag :lookup
  test "Given word shown and existing lookup When applied Then counter is increased" do
    assert Lookup.apply(%Lookup{word: "testMe", views: 1}, %Lookup.Events.WordShown{word: "testMe", views: 2}) ==
          %Lookup{word: "testMe", views: 2}
  end

  @tag :unit
  @tag :lookup
  test "Given no new lookup When showing a word Then word shown event is raised" do
    assert   %Lookup.Events.WordShown{word: "fog", views: 1} ==
              Lookup.execute(%Lookup{},
                             %Lookup.Commands.ShowWord{word: "fog"})
  end

  @tag :unit
  @tag :lookup
  test "Given lookup When showing a word Then word shown event is raised" do

    assert   %Lookup.Events.WordShown{word: "fog", views: 1} ==
                  Lookup.execute(%Lookup{word: "fog"}, %Lookup.Commands.ShowWord{word: "fog"})
  end

  @tag :unit
  @tag :lookup
  test "Given lookup word When showing another word Then eror is raised" do
    catch_error  Lookup.execute(%Lookup{word: "cloud"},
                   %Lookup.Commands.ShowWord{word: "fog"})
  end

end
