defmodule LunchDatastore.Database.Group do
  use Ecto.Schema

  schema "party" do
    field :name, :string
    timestamps()
  end
end
