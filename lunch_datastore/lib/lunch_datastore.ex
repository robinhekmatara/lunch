defmodule LunchDatastore do

  import Ecto.Query, only: [from: 2]

  alias LunchDatastore.Database.Repo

  alias LunchDatastore.Database.ChosenAlternative
  alias LunchDatastore.Database.Group
  alias LunchDatastore.Database.GroupUser
  alias LunchDatastore.Database.User

  def insert_user(name) do
    %User{name: name}
    |> Repo.insert(
        on_conflict: {:replace_all_except, [:id]},
        conflict_target: :name
      )
  end

  def insert_group(name) do
    { :ok, group } = %Group{name: name}
    |> Repo.insert(on_conflict: :nothing)
    group.id
  end

  def update_group(id, name) do
    { :ok, group } = get_group_by_id(id)
    |> Ecto.Changeset.change(%{name: name})
    |> Repo.update()
    group.id
  end

  def insert_group_user(group_id, user_id) do
    %GroupUser{party_id: group_id, user_id: user_id}
   |> Repo.insert(on_conflict: :nothing)
  end

  def insert_chosen_alternative(id, alternative) do
    %ChosenAlternative{alternative: alternative, party_id: id}
    |> Repo.insert()
  end

  def get_user(username) do
    Repo.one(from u in User,
      where: u.name == ^username
    )
  end

  def get_lunch(id) do
    result = Repo.all(from g in Group,
      join: gu in GroupUser, on: gu.party_id == g.id,
      join: u in User, on: gu.user_id == u.id,
      where: g.id == ^id)
    case result do
      [ h | _ ] -> h
      _         -> nil
    end
  end


  def get_groups_by_user(name) do
    Repo.all(from u in User,
      join: gu in GroupUser, on: gu.user_id == u.id,
      join: g in Group, on: gu.party_id == g.id,
      select: %{group_id: g.id, name: g.name},
      where: u.name == ^name
    )
  end

  def get_group_by_id(id) do
    Repo.one(from g in Group,
      where: g.id == ^id
    )
  end
end
