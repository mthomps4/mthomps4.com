defmodule Dilong.Repo do
  use Ecto.Repo,
    otp_app: :dilong,
    adapter: Ecto.Adapters.Postgres
end
