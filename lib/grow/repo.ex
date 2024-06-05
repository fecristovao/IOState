defmodule Grow.Repo do
  use Ecto.Repo,
    otp_app: :grow,
    adapter: Ecto.Adapters.Postgres
end
