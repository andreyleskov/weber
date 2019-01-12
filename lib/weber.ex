defmodule Weber do
  @moduledoc """
  Documentation for Weber.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Nomisma.hello()
      :world

  """
  def run do
    IO.puts Mix.env
    IO.puts "type a word in english to add it to the dictionary"
    newWord = IO.gets "yes or no? "
    :ok = WordRouter.dispatch(%Word.Commands.Create{normalForm: newWord, language: "en"})
  end
end
