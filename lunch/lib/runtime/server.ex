defmodule Lunch.Runtime.Server do

  alias Lunch.Impl.Core

  use GenServer

  def start_link({ name, user }) do
    GenServer.start_link(__MODULE__, {name, user}, name: process_name(name))
  end

  defp process_name(name) do
    { :via, Registry, {LunchRegistry, name}}
  end

  def init({ name, username }) do
    lunch = LunchDatastore.get_lunch(6)
    |> initialize_lunch({ name, get_user(username) })
    { :ok, lunch }
  end

  def initialize_lunch(nil, { name, user }) do
    default_alternatives = ["Länsrätten", "Zaap", "Filmhuset", "580", "Phils", "Ai Ramen", "TV4", "Lulu"]
    Core.new_lunch(name, default_alternatives, user)
  end

  def initialize_lunch(lunch, { name, user }) do
    default_alternatives = ["Länsrätten", "Zaap", "Filmhuset", "580", "Phils", "Ai Ramen", "TV4", "Lulu"]
    Core.new_lunch(name, default_alternatives, user, lunch.id)
  end

  def handle_call({ :get_lunch }, _from, lunch) do
    lunch = Core.get_lunch(lunch)
    { :stop, :normal, lunch, lunch }
  end

  def handle_call({ :add_user, username}, _from, lunch) do
    lunch = Core.add_user(lunch, get_user(username))
    { :reply, lunch, lunch }
  end

  def handle_call({ :get }, _from, lunch) do
    { :reply, lunch, lunch}
  end

  def terminate(_reason, state) do
    id = insert_group(state.id, state.name)
    Enum.each(state.users, fn user -> LunchDatastore.insert_user(user.name) end)
    Enum.each(state.users, fn user -> insert_group_user(id, user) end)
    LunchDatastore.insert_chosen_alternative(id, state.chosen_alternative)

    state
  end

  defp get_user(username) do
    case LunchDatastore.get_user(username) do
      nil    -> %{ id: nil, name: username }
      dbUser -> %{ id: dbUser.id, name: dbUser.name }
    end
  end

  defp insert_group(nil, name), do: LunchDatastore.insert_group(name)
  defp insert_group(id,  name), do: LunchDatastore.update_group(id, name)

  defp insert_group_user(group_id, %{id: nil, name: name}) do
    user = LunchDatastore.get_user(name)
    LunchDatastore.insert_group_user(group_id, user.id)
  end

  defp insert_group_user(group_id, %{id: user_id, name: name}) do
    LunchDatastore.insert_group_user(group_id, user_id)
  end
end
