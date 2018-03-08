defmodule SimpleCrud.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias SimpleCrud.Client


  schema "clients" do
    field :address, :string
    field :cpf, :string
    field :name, :string
    field :medical_agreement, :string

    has_many :exams, SimpleCrud.Exam

    timestamps()
  end

  @doc false
  def changeset(%Client{} = client, attrs) do
    client
    |> cast(attrs, [:name, :cpf, :address, :medical_agreement])
    |> validate_required([:name, :cpf, :address, :medical_agreement])
    |> unique_constraint(:cpf)
  end
end
