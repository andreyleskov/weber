defmodule Weber.Application do
  @moduledoc """
  Documentation for Weber.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Nomisma.hello()
      :world

  """
  def start(_type, _args) do
    IO.puts Mix.env
    newWord = IO.gets "type a word in english to add it to the dictionary"
    :ok = Weber.Router.dispatch(%Word.Commands.Create{normalForm: newWord,language: "en"})
  end
end
