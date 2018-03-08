defmodule SimpleCrud.ExamType do
  use Ecto.Schema
  import Ecto.Changeset
  alias SimpleCrud.ExamType


  schema "exam_types" do
    field :name, :string
    has_many :exams, SimpleCrud.Exam

    timestamps()
  end

  @doc false
  def changeset(%ExamType{} = exam_type, attrs) do
    exam_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
