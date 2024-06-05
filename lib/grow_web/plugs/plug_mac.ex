defmodule GrowWeb.PlugMac do
  import Plug.Conn
  alias Grow.Devices

  @input_mac_field "x-mac-address"
  @output_mac_field :device_id

  def init(opts), do: opts

  def call(conn, _opts) do
    validate_mac_address(conn)
  end

  defp get_mac_address(conn) do
    case get_req_header(conn, @input_mac_field) do
      [val | _] -> val
      _ -> nil
    end
  end

  defp validate_mac_address(conn), do: get_mac_address(conn) |> validate_mac_address(conn)

  defp validate_mac_address(nil, conn), do: halt_connection(conn)

  defp validate_mac_address(mac, conn) do
    if mac =~ ~r/^([A-Za-z0-9]{2}:){5}[A-Za-z0-9]{2}$/ do
      authenticate(conn, mac)
    else
      halt_connection(conn)
    end
  end

  defp halt_connection(conn) do
    conn
    |> send_resp(401, "Unauthenticated")
    |> halt()
  end

  defp authenticate(conn, mac) do
    case Devices.get_by_mac(mac) do
      nil -> halt_connection(conn)
      device -> Plug.Conn.assign(conn, @output_mac_field, device.id)
    end
  end

end
