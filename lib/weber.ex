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
    children = [
      Weber.Repo,
    ]

    opts = [strategy: :one_for_one, name: Conduit.Supervisor]
    Supervisor.start_link(children, opts)

    newWord = IO.gets "type a word in english to add it to the dictionary "
    Task.start(fn -> Weber.Router.dispatch(%Word.Commands.Create{normalForm: newWord,language: "en"});
               IO.puts "command execution completed" end)
  end
end
