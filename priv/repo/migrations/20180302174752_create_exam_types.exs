defmodule SimpleCrud.Repo.Migrations.CreateExamTypes do
  use Ecto.Migration

  def change do
    create table(:exam_types) do
      add :name, :string

      timestamps()
    end

    create unique_index(:exam_types, [:name])
  end
end
