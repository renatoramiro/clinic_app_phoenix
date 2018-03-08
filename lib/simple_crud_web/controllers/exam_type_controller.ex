defmodule SimpleCrudWeb.ExamTypeController do
  use SimpleCrudWeb, :controller
  alias SimpleCrud.{Repo, ExamType}

  plug :scrub_params, "exam_type" when action in [:create, :update]

  def index(conn, _params) do
    exam_types = Repo.all(ExamType)
    render(conn, "index.json", exam_types: exam_types)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(ExamType, id) do
      exam_type = %ExamType{} ->
        render(conn, "show.json", exam_type: exam_type)
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Exam Type not found!")
    end
  end

  def create(conn, %{"exam_type" => exam_type_params}) do
    changeset = ExamType.changeset(%ExamType{}, exam_type_params)
    case Repo.insert(changeset) do
      {:ok, exam_type} ->
        render(conn, "show.json", exam_type: exam_type)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "exam_type" => exam_type_params}) do
    with exam_type = %ExamType{} <- Repo.get(ExamType, id) do
      changeset = ExamType.changeset(exam_type, exam_type_params)
      case Repo.update(changeset) do
        {:ok, exam_type} ->
          render(conn, "show.json", exam_type: exam_type)
        {:error, changeset} ->
          conn
          |> put_status(400)
          |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
      end
    else
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Exam Type not found!")
    end
  end

  def delete(conn, %{"id" => id}) do
    with exam_type = %ExamType{} <- Repo.get(ExamType, id) do
      case Repo.delete(exam_type) do
        {:ok, _exam_type} ->
          conn
          |> put_status(204)
          |> send_resp(:no_content, "")
        {:error, changeset} ->
          conn
          |> put_status(404)
          |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
      end
    else
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Exam Type not found or deleted!")
    end
  end
end