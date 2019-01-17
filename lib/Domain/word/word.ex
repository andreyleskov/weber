defmodule Word.Commands do
  defmodule Create do
    defstruct [:normalForm, :language]
  end

  defmodule AddSynonym do
    defstruct [:word, :synonym]
  end
end

defmodule Word.Events do
  defmodule Created do
    defstruct [:normalForm, :language]
  end

  defmodule SynonymAdded do
    defstruct [:word, :synonym]
  end

end

defmodule Word do

  defstruct [:normalForm,
             :language,
             :explanations,
             :antonyms,
             :examples,
             :image,
             synonyms: []]
  alias Word.Commands
  alias Word.Events
# public command API
  def execute(%Word{normalForm: nil},
              %Word.Commands.Create{normalForm: normalForm, language: language})
    when normalForm != nil and language != nil
  do
    %Word.Events.Created{normalForm: normalForm, language: language}
  end

  def execute(%Word{normalForm: normalForm, synonyms: synonyms},
              %Word.Commands.AddSynonym{word: word, synonym: synonym})
    when normalForm != nil and normalForm == word
  do
    if(synonym not in synonyms) do
      %Word.Events.SynonymAdded{word: word, synonym: synonym}
    else
      {:error, :dublicated_synonym}
    end
  end

  def apply(%Word{} = state, %Events.Created{normalForm: normalForm, language: language})
  do
      %Word{state | normalForm: normalForm, language: language}
  end


  def apply(%Word{normalForm: normalForm, synonyms: synonyms} = state,
            %Events.SynonymAdded{word: word, synonym: synonym})
  do
    %Word{state | synonyms: [synonym | synonyms]}
end
end
