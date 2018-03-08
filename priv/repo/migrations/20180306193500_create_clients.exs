defmodule SimpleCrud.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :cpf, :string
      add :address, :text
      add :medical_agreement, :string

      timestamps()
    end

    create unique_index(:clients, [:cpf])
  end
end
