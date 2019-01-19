defmodule Weber.CLI.Executor do
  def execute(optimusParseResult) do
    case optimusParseResult do
        {[:synonym], %{args: %{word: word, synonym: synonym}}} ->
          IO.puts "Adding synonym #{synonym} to #{word}"
        {[:antonym], %{args: %{word: word, antonym: antonym}}} ->
          IO.puts "Adding antonym #{antonym} to #{word}"
        {[:create], %{args: %{word: word}}} -> IO.puts "Creating word #{word}"
        {[:describe], %{args: %{word: word, description: description}}} ->
          IO.puts "Describing word #{word} as #{description}"
        {[:examples], %{args: %{word: word, examples: examples}}} ->
          IO.puts "Providing examples for #{word} as #{examples}"
        {[:illustrate], %{args: %{word: word, illustration: illustration}}} ->
          IO.puts "Illustrating word #{word} with image #{illustration}"
        _ -> IO.puts "cannot understand commands"
    end
    end
  end


