defmodule Blinkt do
  @moduledoc """
  This library is a thin wrapper around the [Rust library](https://crates.io/crates/blinkt) for the [Pimoroni Blinkt](https://shop.pimoroni.com/products/blinkt?variant=22408658695).

  It is designed for use with [Nerves](https://nerves-project.org/).

  ## Examples

  ```elixir
  :ok = Blinkt.set_brightness(1.0)
  :ok = Blinkt.set_pixel(0, 255, 0, 0)
  :ok = Blinkt.show()
  ```
  """

  use Rustler,
    otp_app: :blinkt,
    crate: "blinkt",
    target: System.get_env("RUSTLER_TARGET")

  @type error :: {:error, String.t}

  @doc """
  Set a specific pixel on the Blinkt to a given set of RGB values.

  pixel must be a value between 0-7 (inclusive).
  r, g and b must be between 0-255 (inclusive).
  """
  @spec set_pixel(byte, byte, byte, byte) :: :ok
  def set_pixel(_pixel, _r, _g, _b), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Set the brightness of an individual pixel.

  pixel must be a value between 0-7 (inclusive)
  brightness must be a value between 0.0 and 1.0 (inclusive)
  """
  @spec set_pixel_brightness(byte, float) :: :ok
  def set_pixel_brightness(_pixel, _brightness), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Set all pixels on the strip to the given RGB value.

  r, g and b must be between 0-255 (inclusive)
  """
  @spec set_all_pixels(byte, byte, byte) :: :ok
  def set_all_pixels(_r, _g, _b), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Set the brightness of all pixels on the strip

  brightness must be a value between 0.0-1.0 (inclusive)
  """
  @spec set_brightness(float) :: :ok
  def set_brightness(_brightness), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Send the pixel data to the Blinkt. If this is not called, nothing will be displayed on the Blinkt.
  """
  @spec show :: :ok | error
  def show(), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Returns a string with the internal pixel buffer, for debugging purposes.
  """
  @spec debug_state :: String.t
  def debug_state(), do: :erlang.nif_error(:nif_not_loaded)
end
