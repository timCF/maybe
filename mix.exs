defmodule Maybe.Mixfile do
  use Mix.Project

  def project do
    [app: :maybe,
     version: "0.0.1",
     #elixir: "~> 1.1.0",
     deps: deps(),

     description: "Type conversions without exceptions",
     source_url: "https://github.com/timCF/maybe",
     package: [
       licenses: ["Apache 2.0"],
       maintainers: ["Ilja Tkachuk aka timCF"],
       links: %{
         "GitHub" => "https://github.com/timCF/maybe",
         "Author's home page" => "https://timcf.github.io/"
       }
     ],
     # Docs
     name: "Maybe",
     docs: [main: "Maybe", extras: ["README.md"]],

    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications:  [
                      :logger
                    ],
     mod: {Maybe, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.16", only: :dev, runtime: false}]
  end
end
