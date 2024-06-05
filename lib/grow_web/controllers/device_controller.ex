defmodule GrowWeb.DeviceController do
  alias Grow.Devices
  use GrowWeb, :controller

  def index(conn, _opts) do
    device_id = conn.assigns[:device_id]
    device = Devices.get_device!(device_id) |> Grow.Repo.preload(:states)
    conn |> json(device)
  end

  def create_device(conn, params) do
    case Devices.create_device(params) do
      {:ok, created} -> conn |> put_status(:created) |> json(created)
      {:error, %{errors: [mac_address: {error, _}]}} -> conn |> put_status(:bad_request) |> json(error)
    end
  end

  def update_state(conn, %{"pin" => pin, "active" => active}) do
    device_id = conn.assigns[:device_id]

    with state when not is_nil(state) <- Grow.States.get_state_by_pin_id(device_id, pin) do
      case Grow.States.update_state(state, %{active: active}) do
        {:ok, _} -> conn |> send_resp(:ok, "")
        {:error, _} -> conn |> send_resp(:bad_request, "")
      end
    else
      nil -> conn |> put_status(:bad_request)
    end
  end

  def create_state(conn, params) do
    device_id = conn.assigns[:device_id]
    case Grow.States.create_state_child(device_id, params) do
      {:ok, _} -> conn |> send_resp(204, "")
      {:error, _} -> conn |> send_resp(:bad_request, "")
    end
  end
end
