defmodule SimpleCrud.Repo.Migrations.AddEnabledToEmployees do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      add :enabled, :boolean, default: true
    end
  end
end
