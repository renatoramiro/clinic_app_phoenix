defmodule SimpleCrudWeb.ExamController do
  use SimpleCrudWeb, :controller
  alias SimpleCrud.{Repo, Exam}
  plug :scrub_params, "exam" when action in [:create, :update]

  defp preload_exam(exam) do
    Repo.preload(exam, [:client, :employee, :exam_type])
  end

  def index(conn, _params) do
    exams = Repo.all(Exam)
    render(conn, "index.json", exams: Repo.preload(exams, [:client, :employee, :exam_type]))
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Exam, id) do
      exam = %Exam{} ->
        render(conn, "show.json", exam: preload_exam(exam))
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Exam not found!")
    end
  end

  def create(conn, %{"exam" => params}) do
    changeset = Exam.changeset(%Exam{}, params)
    case Repo.insert(changeset) do
      {:ok, exam} ->
        render(conn, "show.json", exam: preload_exam(exam))
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "exam" => params}) do
    with exam = %Exam{} <- Repo.get(Exam, id) do
      changeset = Exam.changeset(exam, params)
      case Repo.update(changeset) do
        {:ok, exam} ->
          render(conn, "show.json", exam: preload_exam(exam))
        {:error, changeset} ->
          conn
          |> put_status(400)
          |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
      end
    else
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Exam not found!")
    end
  end
end