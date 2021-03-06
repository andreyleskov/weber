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
      supervisor(Weber.Projection.Repo, []),
      supervisor(Weber.Word.Supervisor, []),
      supervisor(Weber.Lookup.Supervisor, [])
    ]

    opts = [strategy: :one_for_one,
            name: Weber.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def create_new_word() do
    newWord = IO.gets "type a word in english to add it to the dictionary "
    executionResult = Weber.Router.dispatch(%Word.Commands.Create{word: newWord,description: "en"})

    case executionResult do
      :ok ->  IO.puts "word added"
      {:error, reason} -> IO.puts "Could not add word due to error: #{reason}"
    end
  end

  def stop(state) do
     :ok
  end

end
