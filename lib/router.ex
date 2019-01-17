defmodule Weber.Router do
  use Commanded.Commands.Router

  identify Word, by: :word
  dispatch [Word.Commands.Create,
            Word.Commands.AddSynonym], to: Word
end
