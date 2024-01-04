defmodule Lunch.Runtime.Application do

  use Application

  def start(_type, _args) do
    supervisor_spec = [
      {DynamicSupervisor, strategy: :one_for_one, name: __MODULE__},
      {Registry, keys: :unique, name: LunchRegistry},
      {Phoenix.PubSub, name: :my_pubsub},
    ]
    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)

  end

  def server_process(name, user) do
    case start_child(name, user) do
      { :ok, pid }                          -> { :ok, pid }
      { :error, { :already_started, pid } } -> { :already_started, pid }
    end
  end

  defp start_child(name, user) do
    DynamicSupervisor.start_child(__MODULE__, {Lunch.Runtime.Server, {name, user}})
  end
end
