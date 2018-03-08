defmodule SimpleCrud.Repo.Migrations.CreateExams do
  use Ecto.Migration

  def change do
    create table(:exams) do
      add :entry_date, :utc_datetime
      add :price, :decimal
      add :client_id, references(:clients, on_delete: :nothing)
      add :employee_id, references(:employees, on_delete: :nothing)
      add :exam_type_id, references(:exam_types, on_delete: :nothing)

      timestamps()
    end

    create index(:exams, [:client_id])
    create index(:exams, [:employee_id])
    create index(:exams, [:exam_type_id])
  end
end
