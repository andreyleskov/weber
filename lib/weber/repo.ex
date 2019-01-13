defmodule Weber.Repo do
  use Ecto.Repo,
    otp_app: :weber,
    adapter: Ecto.Adapters.Postgres
end
