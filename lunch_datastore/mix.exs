defmodule LunchDatastore.MixProject do
  use Mix.Project

  def project do
    [
      app: :lunch_datastore,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {LunchDatastore.Application, []},
      extra_applications: [:logger, :observer, :wx]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
