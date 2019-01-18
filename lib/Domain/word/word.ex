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
end

defmodule Word.Events do
  defmodule Created do
    defstruct [:word, :description]
  end

  defmodule Described do
    defstruct [:word, :description]
  end

  defmodule SynonymAdded do
    defstruct [:word, :synonym]
  end

end

defmodule Word do

  defstruct [:word,
             :examples,
             :image,
             :description,
             synonyms: [],
             antonyms: [],
            ]
  alias Word.Commands
  alias Word.Events
  def execute(%Word{word: nil},
              %Word.Commands.Create{word: word, description: description})
    when word != nil and description != nil
  do
    %Word.Events.Created{word: word, description: description}
  end

  def execute(%Word{word: word, synonyms: synonyms},
              %Word.Commands.AddSynonym{word: word, synonym: synonym})
    when word != nil and word == word
  do
    if(synonym not in synonyms) do
      %Word.Events.SynonymAdded{word: word, synonym: synonym}
    else
      {:error, :dublicated_synonym}
    end
  end

  def execute(%Word{word: word},
              %Word.Commands.Describe{word: cword, description: description})
    when word != nil and word == cword
  do
      %Word.Events.Described{word: word, description: description}
  end

  def apply(%Word{} = state, %Events.Created{word: word, description: description})
  do
      %Word{state | word: word, description: description}
  end


  def apply(%Word{word: word, synonyms: synonyms} = state,
            %Events.SynonymAdded{word: word, synonym: synonym})
  do
    %Word{state | synonyms: [synonym | synonyms]}
  end

  def apply(%Word{} = state, %Events.Described{word: word, description: description})
  do
      %Word{state | word: word, description: description}
  end

end
