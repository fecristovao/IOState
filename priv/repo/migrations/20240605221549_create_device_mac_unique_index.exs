defmodule Grow.Repo.Migrations.CreateDeviceMacUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:devices, [:mac_address])
  end
end
