defmodule Lunch.Runtime.Server do

  alias Lunch.Impl.Core

  use GenServer

  def start_link({name, user}) do
    GenServer.start_link(__MODULE__, Core.new_lunch(["Länsrätten", "Zaap", "Filmhuset", "580", "Phils", "Ai Ramen", "TV4", "Lulu"], name, user), name: process_name(name))
  end

  defp process_name(name) do
    { :via, Registry, {LunchRegistry, name}}
  end

  def init(state) do
    { :ok, state}
  end

  def handle_call({ :get_lunch }, _from, lunch) do
    lunch = Core.get_lunch(lunch)
    { :reply, lunch, lunch }
  end

  def handle_call({ :add_user, user}, _from, lunch) do
    lunch = Core.add_user(lunch, user)
    { :reply, lunch, lunch }
  end

  def handle_call({ :get }, _from, lunch) do
    { :reply, lunch, lunch}
  end
end
