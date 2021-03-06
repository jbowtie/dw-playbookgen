defmodule Playbook.Mixfile do
  use Mix.Project

  def project do
    [app: :playbook,
     version: "0.4.0",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Playbook, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_pubsub,
                    :phoenix_ecto, :postgrex, :earmark, :connection,
                    :decimal, :edib]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.2.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0-rc"},
     {:postgrex, "~> 0.11.2"},
     {:phoenix_html, "~> 2.3"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:earmark, "~> 0.2.1" },
     {:exrm, "~> 1.0.5"},
     {:edib, "~> 0.7.0"},
     {:cowboy, "~> 1.0"}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
