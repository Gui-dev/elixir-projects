# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :apipay,
  ecto_repos: [Apipay.Repo]

# Configures the endpoint
config :apipay, ApipayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wFsAjT6yeELGn3FmuftT6rjmrrE9TqhX3PSZSv6uKM5Gwbmv0iRPowHRsjtDm0Dm",
  render_errors: [view: ApipayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Apipay.PubSub,
  live_view: [signing_salt: "AhHJkDO+"]

config :apipay, Apipay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :apipay, :basic_auth,
  username: "admin",
  password: "123456"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
