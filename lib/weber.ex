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
  def start(type, args) do
    import Supervisor.Spec

    children = [
      supervisor(Weber.Repo, []),
      supervisor(Weber.Word.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Weber.Supervisor]
    Supervisor.start_link(children, opts)

    newWord = IO.gets "type a word in english to add it to the dictionary "

    Weber.Router.dispatch(%Word.Commands.Create{normalForm: newWord,language: "en"});



    Task.start(fn -> IO.puts "command execution completed" end)
  end
end
