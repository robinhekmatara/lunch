import Config

config :logger,
  handle_otp_reports: true,
  handle_sasl_reports: true

config :lunch_datastore, LunchDatastore.Database.Repo,
database: "lunch_datastore_repo",
username: "lunch",
password: "lunch",
hostname: "localhost"
