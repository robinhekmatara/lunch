defmodule LunchDatastore.Database.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :name, :string
    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
