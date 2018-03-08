defmodule SimpleCrud.Exam do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias SimpleCrud.Exam


  schema "exams" do
    field :entry_date, :utc_datetime, default: DateTime.utc_now
    field :price, :decimal

    belongs_to :client, SimpleCrud.Client
    belongs_to :employee, SimpleCrud.Employee
    belongs_to :exam_type, SimpleCrud.ExamType

    timestamps()
  end

  @doc false
  def changeset(%Exam{} = exam, attrs) do
    exam
    |> cast(attrs, [:entry_date, :price, :client_id, :employee_id, :exam_type_id])
    |> validate_required([:entry_date, :price, :client_id, :employee_id, :exam_type_id])
    |> assoc_constraint(:client)
    |> assoc_constraint(:employee)
    |> assoc_constraint(:exam_type)
    |> validate_employee_enabled(:employee_id)
  end

  @doc """
  Check if employee has been found and is enabled
  """
  def validate_employee_enabled(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, employee_id ->
      case SimpleCrud.Repo.get_by(SimpleCrud.Employee, enabled: true, id: employee_id) do
        _employee = %SimpleCrud.Employee{} ->
          []
        nil ->
          [{:employee, options[:message] || "Employee not found or disabled!"}]
      end
    end)
  end

  def report_between_dates(start_date, end_date) do
    from e in Exam,
      where: e.entry_date >= ^start_date and e.entry_date <= ^end_date,
      select: e
  end

  def report_employee_id(query, employee_id) do
    query
    |> where([e], e.employee_id == ^employee_id)
  end

  def report_employee_enabled(query) do
    query
    |> join(:inner, [e], em in assoc(e, :employee), em.enabled == true)
  end
end
