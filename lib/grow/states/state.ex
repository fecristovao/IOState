defmodule Grow.States.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :active, :boolean, default: false
    field :name, :string
    field :pin, :integer

    timestamps(type: :utc_datetime)
    belongs_to :device, Grow.Devices.Device
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:pin, :name, :active])
    |> validate_required([:pin, :name, :active])
  end
end
