defmodule Grow.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :webhook_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
