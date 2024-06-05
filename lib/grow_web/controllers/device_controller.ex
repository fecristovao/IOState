defmodule GrowWeb.DeviceController do
  alias Grow.Devices
  use GrowWeb, :controller

  def index(conn, _opts) do
    device = conn.assigns[:device]
    conn |> json(device)
  end

  def create_device(conn, params) do
    case Devices.create_device(params) do
      {:ok, created} -> conn |> put_status(:created) |> json(created)
      {:error, %{errors: [mac_address: {error, _}]}} -> conn |> put_status(:bad_request) |> json(error)
    end
  end

  def update_state(conn, params) do

  end
end
