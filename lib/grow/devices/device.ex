defmodule Grow.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :name, :string
    field :webhook_url, :string

    timestamps(type: :utc_datetime)
    has_many :states, Grow.States.State
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :webhook_url])
    |> validate_required([:name, :webhook_url])
  end
end
