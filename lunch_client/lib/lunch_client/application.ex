defmodule LunchClient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LunchClientWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:lunch_client, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LunchClient.PubSub},
      # Start a worker by calling: LunchClient.Worker.start_link(arg)
      # {LunchClient.Worker, arg},
      # Start to serve requests, typically the last entry
      LunchClientWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LunchClient.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LunchClientWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
