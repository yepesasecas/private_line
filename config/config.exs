# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :private_line,
  ecto_repos: [PrivateLine.Repo]

# Configures the endpoint
config :private_line, PrivateLine.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2T1PZV4GQnm0qmhIxD5K0Tstgz5XGUITf8co/mYncX6/y7J+jSB+0TZadNwBeB/r",
  render_errors: [view: PrivateLine.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PrivateLine.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
