defmodule Weber.Projection.Repo do
  use Ecto.Repo,
    otp_app: :weber,
    adapter: Ecto.Adapters.Postgres

 # def init(_type, config) do
 #   IO.inspect(config)
 #   {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
 # end
end

defmodule Weber.Journal.Repo do
  use Ecto.Repo,
    otp_app: :weber,
    adapter: Ecto.Adapters.Postgres

   # def init(_type, config) do
   #   IO.inspect(config)
   #   {:ok, Keyword.put(config, :url, System.get_env("DATABASE_URL"))}
   # end
end

