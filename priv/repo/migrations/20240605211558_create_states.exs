defmodule Grow.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :pin, :integer
      add :name, :string
      add :active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
