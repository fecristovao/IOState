defmodule Grow.DevicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grow.Devices` context.
  """

  @doc """
  Generate a device.
  """
  def device_fixture(attrs \\ %{}) do
    {:ok, device} =
      attrs
      |> Enum.into(%{
        name: "some name",
        webhook_url: "some webhook_url"
      })
      |> Grow.Devices.create_device()

    device
  end
end
