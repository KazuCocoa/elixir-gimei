defmodule Gimei.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gimei,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      description: "Gimei is a pure Elixir library for genrating Japanese fake data.",
      package: package,
      name: "Gimei",
      source_url: "https://github.com/KazuCocoa/elixir-gimei",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [applications: [:logger, :yamerl]]
  end

  defp deps do
    [
      {:yamerl, github: "yakaz/yamerl", tag: "v0.3.2-1"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "mix.lock"],
      contributors: ["Kazuaki Matsuo"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/KazuCocoa/elixir-gimei"}
    ]
  end
end
