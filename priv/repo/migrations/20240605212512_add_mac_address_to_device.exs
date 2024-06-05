defmodule Grow.Repo.Migrations.AddMacAddressToDevice do
  use Ecto.Migration

  def change do
    alter table(:devices) do
      add :mac_address, :string
    end
  end
end
