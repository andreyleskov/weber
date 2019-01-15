# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :weber, Weber.Projection.Repo,
  database: "weber_read",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

#for mix ecto tasks
config :weber, ecto_repos: [Weber.Projection.Repo]

config :commanded_ecto_projections,
  repo: Weber.Projection.Repo

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "weber_dev",
  hostname: "localhost",
  pool_size: 10
