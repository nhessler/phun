defmodule Phun.Repo do
  use Ecto.Repo,
    otp_app: :phun,
    adapter: Ecto.Adapters.Postgres
end
