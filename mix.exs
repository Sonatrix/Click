defmodule Click.MixProject do
  use Mix.Project

  def project do
    [
      app: :click,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/Sonatrix/Click",
      description: description(),
      package: package()
    ]
  end

  defp description() do
    "Process a set of IP clicks based on constraint"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "click",
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README* test),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/Sonatrix/Click"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 3.0"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
