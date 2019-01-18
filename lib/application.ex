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
    IO.puts "starting the app"

    children = [
      supervisor(Weber.Projection.Repo, []),
      supervisor(Weber.Word.Supervisor, [])
    ]

    opts = [strategy: :one_for_one,
            name: Weber.Supervisor]

    task = Supervisor.start_link(children, opts)

    if(Mix.env() != :test) do
      create_new_word()
      :timer.sleep(2000);

    end

    task
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
