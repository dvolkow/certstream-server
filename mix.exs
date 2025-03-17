defmodule Certstream.Mixfile do
  use Mix.Project

  def project do
    [
      app: :certstream,
      version: "1.6.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Certstream, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 2.8"},
      {:easy_ssl, github: "CaliDog/EasySSL", branch: "master"},
      {:httpoison, "~> 2.2.2"},
      {:instruments, "~> 1.1"},
      {:jason, "~> 1.4.4"},
      {:number, "~> 1.0"},
      {:ch, "~> 0.3.0"},
      {:dotenvy, "~> 1.0.1"},
      {:pobox, "~> 1.2"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.13", only: :test}
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end
end
