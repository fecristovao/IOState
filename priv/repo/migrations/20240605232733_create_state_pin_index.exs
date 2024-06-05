defmodule Grow.Repo.Migrations.CreateStatePinIndex do
  use Ecto.Migration

  def change do
    create unique_index(:states, [:pin, :device_id])
  end
end
