# Blinkt

This library is a thin wrapper around the [Rust library](https://crates.io/crates/blinkt) for the [Pimoroni Blinkt](https://shop.pimoroni.com/products/blinkt?variant=22408658695).

It is designed for use with [Nerves](https://nerves-project.org/).

You can depend on it with the following dependency in your `mix.exs`:

```elixir
def deps do
  [
    {:blinkt, "~> 0.1.0", github: "ashhhleyyy/blinkt-ex"},
  ]
end
```
