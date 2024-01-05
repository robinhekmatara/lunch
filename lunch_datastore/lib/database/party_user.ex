defmodule LunchDatastore.Database.PartyUser do
  use Ecto.Schema

  schema "party_user" do
    field :party_id, :integer
    field :user_id,  :integer
    timestamps()
  end
end
