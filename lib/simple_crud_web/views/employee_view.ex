defmodule SimpleCrudWeb.EmployeeView do
  use SimpleCrudWeb, :view

  def render("index.json", %{employees: employees}) do
    %{data: render_many(employees, SimpleCrudWeb.EmployeeView, "employee.json")}
  end

  def render("show.json", %{employee: employee}) do
    %{data: render_one(employee, SimpleCrudWeb.EmployeeView, "employee.json")}
  end

  def render("employee.json", %{employee: employee}) do
    %{
      id: employee.id,
      name: employee.name,
      position: employee.position,
      enabled: employee.enabled,
      inserted_at: employee.inserted_at,
      updated_at: employee.updated_at
    }
  end
end