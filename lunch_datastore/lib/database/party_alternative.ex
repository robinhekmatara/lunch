defmodule LunchDatastore.Database.PartyAlternative do
  use Ecto.Schema

  schema "party_alternative" do
    field :alternative, :string
    field :party_id,    :integer
    timestamps()
  end
end
