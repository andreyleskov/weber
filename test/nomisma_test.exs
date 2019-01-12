defmodule NomismaTest do
  use ExUnit.Case
  doctest Nomisma

  test "greets the world" do
    assert Nomisma.hello() == :world
  end

  test "adding numbers" do
     assert Nomisma.add(1,3) == 4
     assert Nomisma.substract(10,10) == 0
  end

end
