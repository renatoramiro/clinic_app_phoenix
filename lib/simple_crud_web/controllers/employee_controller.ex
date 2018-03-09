defmodule SimpleCrudWeb.EmployeeController do
  use SimpleCrudWeb, :controller
  alias SimpleCrud.{Employee, Repo}
  import Ecto.Query

  plug :scrub_params, "employee" when action in [:create, :update]

  def index(conn, params) do
    param_enabled = check_enabled(params["enabled"])
    query = from e in Employee,
      where: e.enabled == ^param_enabled,
      select: e
    # employees = Repo.all(query)
    employees = Repo.all(Employee)
    render(conn, "index.json", employees: employees)
  end

  defp check_enabled(enabled) do
    result = case enabled do
      "false" -> false
      _ -> true
    end
    result
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Employee, id) do
      employee = %Employee{} ->
        render(conn, "show.json", employee: employee)
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Employee not found!")
    end
  end

  def create(conn, %{"employee" => employee_params}) do
    changeset = Employee.changeset(%Employee{}, employee_params)
    case Repo.insert(changeset) do
      {:ok, employee} ->
        render(conn, "show.json", employee: employee)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    case Repo.get(Employee, id) do
      employee = %Employee{} ->
        changeset = Employee.changeset(employee, employee_params)
        case Repo.update(changeset) do
          {:ok, employee} ->
            render(conn, "show.json", employee: employee)
          {:error, changeset} ->
            conn
            |> put_status(400)
            |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
        end
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Employee not found!")
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Employee, id) do
      employee = %Employee{} ->
        case Repo.delete(employee) do
          {:ok, _employee} ->
            conn
            |> put_status(204)
            |> send_resp(:no_content, "")
          {:error, changeset} ->
            conn
            |> put_status(400)
            |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
        end
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Employee not found or deleted!")
    end
  end
end