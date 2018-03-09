# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :simple_crud,
  ecto_repos: [SimpleCrud.Repo]

# Configures the endpoint
config :simple_crud, SimpleCrudWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kYyeiGHlOysbMXsz50826zEIcKgdt0fFdPMmgSH93+ws8X4iAmUEHizmUQnX1Q0d",
  render_errors: [view: SimpleCrudWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SimpleCrud.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cors_plug,
      origin: ["*"],
      max_age: 86400,
      methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
# expose: ["authorization", "server"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
