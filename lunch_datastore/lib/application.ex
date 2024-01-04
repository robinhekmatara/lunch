defmodule LunchDatastore.Application do

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LunchDatastore.Database.Repo
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

end
