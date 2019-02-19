# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :meat_gql,
  ecto_repos: [MeatGql.Repo]

# Configures the endpoint
config :meat_gql, MeatGqlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hcRNU3tfFkzoI2ogsB+8KkvRszpG3PVKUD4vtlGUGnPSqH4T9TYP3vUu84P0e9ww",
  render_errors: [view: MeatGqlWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MeatGql.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  #Guardian config details
  #"Secret key. You can use `mix guardian.gen.secret` to get one"
config :meat_gql, MeatGql.Guardian,
  issuer: "meat_gql",
  secret_key: "aPxxZCe5tiD1QX+1S6fhuaZ095cj1DvHShtte0jHLbMZqUj7V42jsYz3LCHAF3MY"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
