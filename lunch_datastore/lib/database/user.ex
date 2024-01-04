defmodule LunchDatastore.Database.User do
  use Ecto.Schema

  schema "user" do
    field :name, :string
    timestamps()
  end
end
