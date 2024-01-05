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
    lunch = LunchDatastore.get_party_with_users_and_alternatives(6)
    |> initialize_lunch({ name, get_user(username) })
    { :ok, lunch }
  end

  def initialize_lunch(nil, { name, user }) do
    Core.new_lunch(name, [user], [])
  end

  def initialize_lunch(%{party_id: id, users: users, alternatives: alternatives}, { name, _ }) do
    Core.new_lunch(name,  users, alternatives, id)
  end

  def handle_call({ :get_lunch }, _from, lunch) do
    lunch = Core.get_lunch(lunch)
    if lunch.chosen_alternative == nil do
      { :reply, lunch, lunch }
    else
      Phoenix.PubSub.broadcast(:my_pubsub, "lunch:#{lunch.name}", {:updated_lunch, lunch})
      { :stop, :normal, lunch, lunch }
    end
  end

  def handle_call({ :add_user, username}, _from, lunch) do
    lunch = Core.add_user(lunch, get_user(username))
    { :reply, lunch, lunch }
  end

  def handle_call({ :get }, _from, lunch) do
    { :reply, lunch, lunch}
  end

  def terminate(reason, state) do
    %{id: id } = insert_party(state.id, state.name)
    Enum.each(state.users, fn user -> LunchDatastore.insert_user(user) end)
    Enum.each(state.users, fn user -> insert_party_user(id, user) end)
    LunchDatastore.insert_chosen_alternative(id, state.chosen_alternative)

    state
  end

  defp get_user(username) do
    case LunchDatastore.get_user(username) do
      nil    -> %{ id: nil, name: username }
      dbUser -> %{ id: dbUser.id, name: dbUser.name }
    end
  end

  defp insert_party(nil, name), do: LunchDatastore.insert_party(name)
  defp insert_party(id,  name), do: LunchDatastore.update_party_name(id, name)

  defp insert_party_user(party_id, name) do
    user = LunchDatastore.get_user(name)
    LunchDatastore.insert_party_user(party_id, user.id)
  end
end
