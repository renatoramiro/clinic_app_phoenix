defmodule SimpleCrudWeb.Router do
  use SimpleCrudWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SimpleCrudWeb do
    pipe_through :api

    resources("/employees", EmployeeController, only: [:index, :show, :create, :update, :delete])
    resources("/exam_types", ExamTypeController)
    resources("/clients", ClientController)
    resources("/exams", ExamController)
    get "/report", ReportController, :monthly_report
  end
end
