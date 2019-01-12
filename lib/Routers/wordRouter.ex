defmodule WordRouter do
  use Commanded.Commands.Router

  identify Word, by: :normalForm
  dispatch [Word.Commands.Create], to: Word
end
