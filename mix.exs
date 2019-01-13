defmodule Nomisma.MixProject do
  use Mix.Project

  def project do
    [
      app: :weber,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
  [
      mod: {Weber.Application, []},
      extra_applications: [:logger, :commanded, :eventstore,],
  ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:commanded, "~> 0.17"},
      {:poolboy, "~> 1.5.1"},
      #{:eventstore, ">= 0.14.0"},
      {:eventstore, github: "commanded/eventstore", branch: "master", override: true},
      {:commanded_eventstore_adapter, "~> 0.4"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
