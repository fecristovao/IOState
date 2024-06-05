defmodule Grow.Repo.Migrations.CreateAssociation do
  use Ecto.Migration

  def change do
    alter table(:states) do
      add :device_id, references(:devices)
    end
  end
end
