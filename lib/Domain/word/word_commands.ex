defmodule Word.Commands do
  defmodule Create do
    defstruct [:word, :description]
  end

  defmodule AddSynonym do
    defstruct [:word, :synonym]
  end

  defmodule Describe do
    defstruct [:word, :description]
  end

  defmodule AddAntonym do
    defstruct [:word, :antonym]
  end

  defmodule ProvideExamples do
    defstruct [:word, :examples]
  end

  defmodule Illustrate do
    defstruct [:word, illustration: %Word.Image{}]
  end
end
