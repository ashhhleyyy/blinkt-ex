defmodule Blinkt.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/ashhhleyyy/blinkt-ex"

  @nerves_rust_target_triple_mapping %{
    "armv6-nerves-linux-gnueabihf": "arm-unknown-linux-gnueabihf",
    "armv7-nerves-linux-gnueabihf": "armv7-unknown-linux-gnueabihf",
    "aarch64-nerves-linux-gnu": "aarch64-unknown-linux-gnu",
    "x86_64-nerves-linux-musl": "x86_64-unknown-linux-musl"
  }

  def project do
    if is_binary(System.get_env("NERVES_SDK_SYSROOT")) do
      components = System.get_env("CC")
        |> tap(&System.put_env("RUSTFLAGS", "-C linker=#{&1}"))
        |> Path.basename()
        |> String.split("-")

      target_triple =
        components
        |> Enum.slice(0, Enum.count(components) - 1)
        |> Enum.join("-")

      mapping = Map.get(@nerves_rust_target_triple_mapping, String.to_atom(target_triple))
      if is_binary(mapping) do
        System.put_env("RUSTLER_TARGET", mapping)
      end
    end

    [
      app: :blinkt,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A library for interacting with a Pimoroni Blinkt",
      package: package(),
    ]
  end

  def application do
    [
      extra_applications: [],
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.25.0"},
    ]
  end

  defp package() do
    [
      files: [
        "lib",
        "native",
        "mix.exs",
        "README.md",
        "LICENSE.txt",
        ".formatter.exs",
      ],
      licenses: ["MPL-2.0"],
      links: %{"GitHub" => @repo_url},
    ]
  end
end
