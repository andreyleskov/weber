use Mix.Config

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "sa",
  password: "P@ssw0rd1",
  database: "eventstore_dev",
  hostname: "localhost:1400",
  pool_size: 10
