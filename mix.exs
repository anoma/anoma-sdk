defmodule Anoma.MixProject do
  use Mix.Project

  def project do
    [
      app: :anoma_sdk,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyze: [
        plt_add_apps: [:mix, :jason]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  # runtime_tools is required for dbg.
  def application do
    [
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:rustler, "~> 0.36.1", runtime: false},
      {:typed_struct, "~> 0.3.0"},
      {:jason, "~> 1.4"}
    ]
  end
end
