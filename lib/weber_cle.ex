defmodule Weber.CLI.Executor do
  def execute(optimusParseResult) do
    case optimusParseResult do
        {[:show], %{args: %{word: nil}}} -> show()
        {[:show], %{args: %{word: word}}} -> show(word)
        {[:synonym], %{args: %{word: word, synonym: synonym}}} -> synonym(word, synonym)
        {[:antonym], %{args: %{word: word, antonym: antonym}}} -> antonym(word, antonym)
        {[:create], %{args: %{word: word}}} -> create(word)
        {[:describe], %{args: %{word: word, description: description}}} -> describe(word, description)
        {[:examples], %{args: %{word: word, examples: examples}}} -> example(word, examples)
        {[:illustrate], %{args: %{word: word, illustration: illustration}}} -> illustrate(word, illustration)
        _ -> IO.puts "cannot understand command"
    end
  end

    defp word_exist(word) do
      nil != Weber.Word.Queries.WordExists.new(word) |>
                Weber.Projection.Repo.one()
    end

    defp create_if_not_exist(word) do
      unless( word_exist(word)) do
        create(word)
      end
    end

    defp describe(word, description) do
      create_if_not_exist(word)
      :ok = Weber.Router.dispatch(%Word.Commands.Describe{word: word, description: description}, consistency: :strong)
      IO.puts "Described"
    end

    defp create(word) do
      :ok = Weber.Router.dispatch(%Word.Commands.Create{word: word}, consistency: :strong)
      IO.puts "Created word #{word}"
    end

    defp synonym(word, synonym) do
      create_if_not_exist(word)
      create_if_not_exist(synonym)
      :ok = Weber.Router.dispatch(%Word.Commands.AddSynonym{word: word, synonym: synonym}, consistency: :strong)
      :ok = Weber.Router.dispatch(%Word.Commands.AddSynonym{word: synonym, synonym: word}, consistency: :strong)
      IO.puts "Synonym added"
    end

    defp antonym(word, antonym) do
      create_if_not_exist(word)
      create_if_not_exist(antonym)
      :ok = Weber.Router.dispatch(%Word.Commands.AddAntonym{word: word, antonym: antonym}, consistency: :strong)
      :ok = Weber.Router.dispatch(%Word.Commands.AddAntonym{word: antonym, antonym: word}, consistency: :strong)
      IO.puts "Antonym added"
    end

    defp example(word, example) do
      create_if_not_exist(word)
      :ok = Weber.Router.dispatch(%Word.Commands.ProvideExamples{word: word, examples: example}, consistency: :strong)
      IO.puts "Example added"
    end

    defp show(word) do

      if(word == nil) do
         Weber.Router.dispatch(%Lookup.Commands.ShowWord{word: :dictionary_contents}, consistency: :strong)
      else
         Weber.Router.dispatch(%Lookup.Commands.ShowWord{word: word}, consistency: :strong)
      end

      wordModel = Weber.Word.Queries.WordByNormalForm.new(word) |>
                            Weber.Projection.Repo.one()


      if(wordModel == nil) do
         IO.puts "No entry for '#{word}'"
      else
        synonyms =  Weber.Word.Queries.SynonymsByWord.new(word) |>
                    Weber.Projection.Repo.all()

        antonyms =  Weber.Word.Queries.AntonymsByWord.new(word) |>
                    Weber.Projection.Repo.all()

        lookup_history = Weber.Lookup.Queries.TotalViews.new(word) |>
                         Weber.Projection.Repo.one()

          IO.puts "--- #{String.upcase(wordModel.normalForm)} ---"
          IO.puts ""
          if(wordModel.description != nil) do
              IO.puts wordModel.description
          else
            IO.puts "* no description *"
          end

          IO.puts ""
          if(wordModel.examples != nil) do
            IO.puts "-- examples --"
            IO.puts wordModel.examples
          else
            IO.puts "* no examples *"
          end

          IO.puts ""
          case synonyms do
           [] -> IO.puts "* no synonyms *"
            _ -> IO.puts "-- synonyms --"
                 Enum.each(synonyms, fn s -> IO.puts s.synonym end)
          end

          IO.puts ""
          case antonyms do
            [] -> IO.puts "* no antonyms *"
            _  -> IO.puts "-- antonyms --"
                 Enum.each(antonyms, fn s -> IO.puts s.antonym end)
          end

          IO.puts ""
          if(wordModel.illustration_binary != nil) do
            IO.puts "has an #{wordModel.illustration_extension} illustration"
            fileName = "#{wordModel.normalForm}#{wordModel.illustration_extension}"

            case File.read fileName do
              {:ok, _} ->
                System.cmd("display",[fileName] )
              {:error, _ }->
                File.write(fileName, wordModel.illustration_binary)
                System.cmd("display", [fileName] )
            end

          else
            IO.puts "* no illustration *"
          end

        if(lookup_history != nil) do
          IO.puts "-- Lookup statistics --"
          IO.puts "#{lookup_history.total_views} total views"
          IO.puts "last searched at #{lookup_history.occured_at}"
        else
          IO.puts "* no lookup history *"
        end
      end
    end

    defp show() do
      topWords = Weber.Word.Queries.TopWords.new() |>
                         Weber.Projection.Repo.all()

         IO.puts "--- Contents ---"
         Enum.each(topWords, fn w -> IO.puts w.normalForm end)
         :ok
    end

    defp illustrate(word, imagePath) do
      case File.read imagePath do
        {:ok, binary} ->
          command = %Word.Commands.Illustrate{word: word,
                                              illustration: %Word.Image{ base64: Base.encode64(binary),
                                                                         extension: Path.extname(imagePath)}}
          :ok = Weber.Router.dispatch(command, consistency: :strong)
        {:error, error }->
          IO.puts "Cannot find image under given path"
          error
      end
    end

  end


