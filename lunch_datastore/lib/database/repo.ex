defmodule LunchDatastore.Database.Repo do
  use Ecto.Repo,
    otp_app: :lunch_datastore,
    adapter: Ecto.Adapters.Postgres
end
