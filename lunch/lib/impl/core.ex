defmodule Lunch.Impl.Core do

  defstruct(
    name: nil,
    users: [],
    join_code: nil,
    alternatives: [],
    chosen_alternative: nil
  )

  def new_lunch(alternatives, name, user) do
    %__MODULE__{
      name: name,
      alternatives: alternatives,
      join_code: "123",
      users: [user]
    }
  end

  def add_alternative(lunch, alternative) do
    %{lunch | alternatives: [alternative | lunch.alternatives]}
  end

  def add_user(lunch, user) do
    %{lunch | users: [user | lunch.users]}
  end

  def get_lunch(lunch) do
    %{lunch | chosen_alternative: Enum.random(lunch.alternatives)}
  end
end
