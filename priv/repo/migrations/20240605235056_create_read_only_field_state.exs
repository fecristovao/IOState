defmodule Grow.Repo.Migrations.CreateReadOnlyFieldState do
  use Ecto.Migration

  def change do
    alter table(:states) do
      add :read_only, :boolean
    end
  end
end
