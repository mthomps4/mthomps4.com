# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dilong,
  ecto_repos: [Dilong.Repo]

# Configures the endpoint
config :dilong, DilongWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f6zfG066BeqnaR3TNTk8ErvRmcJNtsXx9sbQTubr9tHGYdcuZ318RCTxR2IGdiL1",
  render_errors: [view: DilongWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dilong.PubSub,
  live_view: [signing_salt: "7EjdXslF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
