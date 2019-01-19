defmodule Weber.CLI.Executor do
  def execute(optimusParseResult) do
    case optimusParseResult do
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


    defp describe(word, description) do
      :ok = Weber.Router.dispatch(%Word.Commands.Describe{word: word, description: description}, consistency: :strong)
      IO.puts "Described"
    end

    defp create(word) do
      :ok = Weber.Router.dispatch(%Word.Commands.Create{word: word}, consistency: :strong)
      IO.puts "Created"
    end

    defp synonym(word, synonym) do
      :ok = Weber.Router.dispatch(%Word.Commands.AddSynonym{word: word, synonym: synonym}, consistency: :strong)
      IO.puts "Synonym added"
    end

    defp antonym(word, antonym) do
      :ok = Weber.Router.dispatch(%Word.Commands.AddAntonym{word: word, antonym: antonym}, consistency: :strong)
      IO.puts "Antonym added"
    end

    defp example(word, example) do
      :ok = Weber.Router.dispatch(%Word.Commands.ProvideExamples{word: word, examples: example}, consistency: :strong)
      IO.puts "Example added"
    end

    defp show(word) do
      #TODO: we do not care about queries numbers, as readmodel is fast
      # and we can refactor it to one query easily

          wordModel = Weber.Word.Queries.WordByNormalForm.new(word) |>
                            Weber.Projection.Repo.one()

          IO.inspect wordModel

          Weber.Word.Queries.SynonymsByWord.new(word) |>
                            Weber.Projection.Repo.one() |>
                            IO.inspect

          Weber.Word.Queries.AntonymsByWord.new(word) |>
                            Weber.Projection.Repo.one() |>
                            IO.inspect

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

