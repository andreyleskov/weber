defmodule Word.Events do
  defmodule Created do
    defstruct [:word, :description]
  end

  defmodule Described do
    defstruct [:word, :description]
  end

  defmodule ExamplesProvided do
    defstruct [:word, :examples]
  end

  defmodule SynonymAdded do
    defstruct [:word, :synonym]
  end

  defmodule AntonymAdded do
    defstruct [:word, :antonym]
  end
end
