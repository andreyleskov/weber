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
   # import Supervisor.Spech
    IO.puts "starting the app"

    children = [
     # supervisor(Weber.Projection.Repo, []),
     # supervisor(Weber.Word.Supervisor, [])
    ]

    opts = [strategy: :one_for_one,
            name: Weber.Supervisor]

    Supervisor.start_link(children, opts)


   # Weber.Router.dispatch(%Word.Commands.Create{normalForm: newWord,language: "en"});
    newWord = IO.gets "type a word in english to add it to the dictionary "

    :timer.sleep(2000);

    Task.start(fn ->

      IO.puts "command execution completed"
    end)
  end
end
