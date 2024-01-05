defmodule LunchDatastore do

  import Ecto.Query, only: [from: 2]

  alias LunchDatastore.Database.Repo

  alias LunchDatastore.Database.ChosenAlternative
  alias LunchDatastore.Database.Party
  alias LunchDatastore.Database.PartyUser
  alias LunchDatastore.Database.PartyAlternative
  alias LunchDatastore.Database.User

  def insert_user(name) do
    case %User{}
    |> User.changeset(%{ name: name })
    |> Repo.insert() do
      { :ok, user} ->
        user
      { :error, changeset} ->
        IO.inspect(changeset)
        get_user(name)
    end
  end

  def insert_party(name) do
    {:ok, party } = %Party{name: name}
    |> Repo.insert()
    party
  end

  def update_party_name(id, name) do
    {:ok, party } = get_party_by_id(id)
    |> Ecto.Changeset.change(%{name: name})
    |> Repo.update()
    party
  end

  def insert_party_user(party_id, user_id) do
    { :ok, party_user } = %PartyUser{party_id: party_id, user_id: user_id}
    |> Repo.insert(on_conflict: :nothing)
    party_user
  end

  def insert_chosen_alternative(id, alternative) do
    { :ok, chosen_alternative } = %ChosenAlternative{alternative: alternative, party_id: id}
    |> Repo.insert()
    chosen_alternative
  end

  def insert_party_alternative(id, alternative) do
    { :ok, party_alternative } = %PartyAlternative{alternative: alternative, party_id: id}
    |> Repo.insert()
    party_alternative
  end

  def get_user(username) do
    Repo.one(from u in User,
      where: u.name == ^username
    )
  end

  def get_party_with_users_and_alternatives(id) do
    Repo.one(from p in Party,
      left_join: pu in PartyUser, on: pu.party_id == p.id,
      left_join: pa in PartyAlternative, on: pa.party_id == p.id,
      left_join: u in User, on: pu.user_id == u.id,
      where: p.id == ^id,
      group_by: p.id,
      select: %{
        party_id: p.id,
        party_name: p.name,
        users: fragment("ARRAY_REMOVE(ARRAY_AGG(DISTINCT ?), null)", u.name),
        alternatives: fragment("ARRAY_REMOVE(ARRAY_AGG(DISTINCT ?), null)", pa.alternative)
      })
  end

  def get_parties_by_user(name) do
    Repo.all(from u in User,
      join: pu in PartyUser, on: pu.user_id == u.id,
      join: p in Party, on: pu.party_id == p.id,
      select: %{party_id: p.id, name: p.name},
      where: u.name == ^name
    )
  end

  def get_party_by_id(id) do
    Repo.one(from p in Party,
      where: p.id == ^id
    )
  end
end
