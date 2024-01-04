import Config

config :lunch_datastore, LunchDatastore.Database.Repo,
  database: "lunch_datastore_repo",
  username: "lunch",
  password: "lunch",
  hostname: "localhost"

config :lunch_datastore, ecto_repos: [LunchDatastore.Database.Repo]

config :logger,
  handle_otp_reports: true,
  handle_sasl_reports: true
