# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :playbook, Playbook.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xDamRe3Gqg9JGDhkevTsX7HxhUVeafgP4DQL1dlb7UvFP42DFylDG+dn/3GRt8IE",
  render_errors: [default_format: "html"],
  pubsub: [name: Playbook.PubSub,
           adapter: Phoenix.PubSub.PG2],
  ecto_repos: [Playbook.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
