defmodule Word.Commands do
  defmodule Create do
    defstruct [:word, :language]
  end

  defmodule AddSynonym do
    defstruct [:word, :synonym]
  end
end

defmodule Word.Events do
  defmodule Created do
    defstruct [:word, :language]
  end

  defmodule SynonymAdded do
    defstruct [:word, :synonym]
  end

end

defmodule Word do

  defstruct [:word,
             :language,
             :explanations,
             :antonyms,
             :examples,
             :image,
             synonyms: []]
  alias Word.Commands
  alias Word.Events
# public command API
  def execute(%Word{word: nil},
              %Word.Commands.Create{word: word, language: language})
    when word != nil and language != nil
  do
    %Word.Events.Created{word: word, language: language}
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

  def apply(%Word{} = state, %Events.Created{word: word, language: language})
  do
      %Word{state | word: word, language: language}
  end


  def apply(%Word{word: word, synonyms: synonyms} = state,
            %Events.SynonymAdded{word: word, synonym: synonym})
  do
    %Word{state | synonyms: [synonym | synonyms]}
end
end
