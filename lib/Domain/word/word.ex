defmodule Word do
  defstruct [:word,
             :examples,
             :description,
             illustration: %Word.Image{},
             synonyms: [],
             antonyms: [],
            ]
  alias Word.Events
  def execute(%Word{word: nil},
              %Word.Commands.Create{word: word, description: description})
    when word != nil
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

  def execute(%Word{word: word},
              %Word.Commands.ProvideExamples{word: cword, examples: examples})
  when word != nil and word == cword
  do
    %Word.Events.ExamplesProvided{word: word, examples: examples}
  end

  def execute(%Word{word: word, antonyms: antonyms},
              %Word.Commands.AddAntonym{word: word, antonym: antonym})
  when word != nil and word == word
  do
    if(antonym not in antonyms) do
      %Word.Events.AntonymAdded{word: word, antonym: antonym}
    else
      {:error, :dublicated_antonym}
    end
  end

  def execute(%Word{word: word, antonyms: antonyms},
              %Word.Commands.Illustrate{word: cword, illustration: %Word.Image{extension: extension, base64: base64} = illustration})
  when word != nil and word == cword and extension != "" and base64 != nil
  do
    #TODO: place some illustration consistency check according to its MIME
    %Word.Events.Illustrated{word: word, illustration: illustration}
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

  def apply(%Word{word: word, antonyms: antonyms} = state,
            %Events.AntonymAdded{word: word, antonym: antonym})
  do
    %Word{state | antonyms: [antonym | antonyms]}
  end

  def apply(%Word{} = state,
            %Events.ExamplesProvided{examples: examples})
  do
    %Word{state | examples: examples}
  end

  def apply(%Word{} = state,
            %Events.Illustrated{illustration: illustration})
  do
    %Word{state | illustration: illustration}
  end

end
