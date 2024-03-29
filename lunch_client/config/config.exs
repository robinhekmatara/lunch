# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :lunch_client,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :lunch_client, LunchClientWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: LunchClientWeb.ErrorHTML, json: LunchClientWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: LunchClient.PubSub,
  live_view: [signing_salt: "hz7hXk38"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :live_view_native,
  plugins: [
    # other plugins here...
    LiveViewNative.SwiftUI,
    LiveViewNative.Jetpack
  ]

# LiveView Native Stylesheet support
# Omit this if you're not using platforms that support LiveView
# Native stylesheets
config :live_view_native_stylesheet,
  parsers: [
    swiftui: LiveViewNative.SwiftUI.RulesParser
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

import_config "native.exs"
config :lunch_datastore, LunchDatastore.Database.Repo,
database: "lunch_datastore_repo",
username: "lunch",
password: "lunch",
hostname: "localhost"
