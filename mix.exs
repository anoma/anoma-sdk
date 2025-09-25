defmodule AnomaSDK.MixProject do
  use Mix.Project

  @version "0.0.2"

  def project do
    [
      app: :anoma_sdk,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      # dialyzer
      dialyze: [
        plt_file: {:no_warn, "priv/plts/project.plt"},
        plt_add_apps: [:mix, :jason, :ex_unit]
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
      extra_applications: [:logger, :runtime_tools, :ex_unit]
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
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true},
      {:rustler_precompiled, "~> 0.8"},
      {:req, "~> 0.5.0", only: :dev}
    ]
  end

  defp docs do
    [
      # The main page in the docs
      logo: "assets/anoma.svg",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native",
        "checksum-*.exs",
        "mix.exs",
        "LICENSE"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/anoma/anoma-sdk"},
      maintainers: ["Christophe De Troyer"]
    ]
  end
end
