defmodule Weber.Router do
  use Commanded.Commands.Router

  identify Word, by: :word
  dispatch [Word.Commands.Create,
            Word.Commands.AddSynonym,
            Word.Commands.Describe,
            Word.Commands.AddAntonym,
            Word.Commands.ProvideExamples,
            Word.Commands.Illustrate], to: Word
end
