defmodule SimpleCrud.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  alias SimpleCrud.Employee


  schema "employees" do
    field :name, :string
    field :position, :string
    field :enabled, :boolean, default: true

    has_many :exams, SimpleCrud.Exam

    timestamps()
  end

  @doc false
  def changeset(%Employee{} = employee, attrs) do
    employee
    |> cast(attrs, [:name, :position, :enabled])
    |> validate_required([:name, :position])
  end
end
