defmodule Weber.Router do
  use Commanded.Commands.Router

  identify Word, by: :word
  identify Lookup, by: :word, prefix: "lookup-"

  dispatch [Word.Commands.Create,
            Word.Commands.AddSynonym,
            Word.Commands.Describe,
            Word.Commands.AddAntonym,
            Word.Commands.ProvideExamples,
            Word.Commands.Illustrate], to: Word
  dispatch [Lookup.Commands.ShowWord], to: Lookup


end
