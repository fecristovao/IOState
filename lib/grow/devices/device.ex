defmodule Grow.Devices.Device do
  @derive {Jason.Encoder, only: [:name, :webhook_url, :mac_address, :states]}
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :name, :string
    field :webhook_url, :string
    field :mac_address, :string

    timestamps(type: :utc_datetime)
    has_many :states, Grow.States.State
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :webhook_url, :mac_address])
    |> validate_required([:mac_address])
    |> validate_format(:mac_address, ~r/^([A-Za-z0-9]{2}:){5}[A-Za-z0-9]{2}$/, message: "MAC Address has invalid format")
    |> unique_constraint(:mac_address, message: "MAC Address already taken")
  end

end
