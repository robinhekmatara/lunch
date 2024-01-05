defmodule Lunch do
  def new_lunch(name, user) do
    case Lunch.Runtime.Application.server_process(name, user) do
      { :already_started, pid} ->
        GenServer.call(pid, {:add_user, user})
        pid
      { _, pid } -> pid
    end
  end

  def get(pid) do
    GenServer.call(pid, {:get})
  end

  def get_lunch(pid) do
    GenServer.call(pid, {:get_lunch})
  end
end
