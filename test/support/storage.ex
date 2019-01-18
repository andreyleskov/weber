defmodule Weber.Tests.Storage do
  @doc """
  Clear the event store and read store databases
  """
  def reset! do
    :ok = Application.stop(:weber)
    :ok = Application.stop(:commanded)
    :ok = Application.stop(:eventstore)

    reset_eventstore()
    reset_readstore()

   {:ok, _} = Application.ensure_all_started(:weber)
  end

  defp reset_eventstore do
    config = EventStore.Config.parsed()
          |> EventStore.Config.default_postgrex_opts()

    {:ok, conn} = Postgrex.start_link(config)
    IO.puts "resetting event storage"
    #IO puts inspect(conn)
    EventStore.Storage.Initializer.reset!(conn)

    Postgrex.query!(conn, truncate_subscription_tables(), [])
    IO.puts "event storage resetted"

  end

  defp reset_readstore do
    config = Application.get_env(:weber, Weber.Projection.Repo)

    {:ok, conn} = Postgrex.start_link(config)
    IO.puts "resetting readmodel"
    Postgrex.query!(conn, truncate_readstore_tables(), [])
    IO.puts "readmodel resetted"

  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      word_register,
      synonyms,
      projection_versions
    RESTART IDENTITY
    CASCADE;
    """
  end

  defp truncate_subscription_tables do
    """
    TRUNCATE TABLE
       subscriptions
    RESTART IDENTITY
    CASCADE;
    """
  end
end
