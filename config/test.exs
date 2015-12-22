use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :playbook, Playbook.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :playbook, Playbook.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "wilderness",
  password: "dev",
  database: "playbook_test",
  pool: Ecto.Adapters.SQL.Sandbox
