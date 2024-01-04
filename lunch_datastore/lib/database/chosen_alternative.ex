defmodule LunchDatastore.Database.ChosenAlternative do
  use Ecto.Schema

  schema "chosen_alternative" do
    field :alternative, :string
    field :party_id,    :integer
    timestamps()
  end
end
