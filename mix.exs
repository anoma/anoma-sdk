defmodule Anoma.MixProject do
  use Mix.Project

  def project do
    [
      app: :anoma_sdk,
      version: "1.0.0-xuyang-bump-risc0-v3",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # dialyzer
      dialyze: [
        plt_add_apps: [:mix, :jason]
      ],
      # docs
      name: "Anoma",
      source_url: "https://github.com/anoma/anoma-sdk",
      homepage_url: "https://github.com/anoma/anoma-sdk",
      docs: &docs/0
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
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true}
    ]
  end

  defp docs do
    [
      # The main page in the docs
      logo: "assets/anoma.svg",
      extras: ["README.md"]
    ]
  end
end
