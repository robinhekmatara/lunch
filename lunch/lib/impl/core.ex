defmodule Lunch.Impl.Core do

  defstruct(
    id: nil,
    name: nil,
    users: [],
    join_code: nil,
    alternatives: [],
    chosen_alternative: nil
  )

  def new_lunch(name, users, alternatives \\ [], id \\ nil) do
    %__MODULE__{
      id: id,
      name: name,
      alternatives: alternatives,
      join_code: "123",
      users: users
    }
  end

  def add_alternative(lunch, alternative) do
    %{lunch | alternatives: [alternative | lunch.alternatives]}
  end

  def add_user(lunch, user) do
    %{lunch | users: [user | lunch.users]}
  end

  def get_lunch(%{alternatives: [ _h | _t ] = alternatives} = lunch)  do
    chosen_alternative = Enum.random(alternatives)

    %{lunch | chosen_alternative: chosen_alternative }
  end

  def get_lunch(%{alternatives: []} = lunch)  do
    lunch
  end
end
