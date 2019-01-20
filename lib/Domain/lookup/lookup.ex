
  defmodule Lookup.Commands do
    defmodule ShowWord do
      defstruct [:word]
    end
  end

  defmodule Lookup.Events do
    defmodule WordShown do
      defstruct [:word, views: 0]
    end
  end


defmodule Lookup do
  defstruct [:word, views: 0]


  def execute(%Lookup{word: word, views: views}, %Lookup.Commands.ShowWord{word: cword})
  when word == cword
  do
    %Lookup.Events.WordShown{word: word, views: views + 1}
  end

  def execute(%Lookup{word: nil}, %Lookup.Commands.ShowWord{word: word}) do
    %Lookup.Events.WordShown{word: word, views: 1}
  end


  def apply(%Lookup{}, %Lookup.Events.WordShown{word: word, views: views}) do
    %Lookup{word: word, views: views}
  end
end
