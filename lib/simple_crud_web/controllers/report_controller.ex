defmodule SimpleCrudWeb.ReportController do
  use SimpleCrudWeb, :controller
  alias SimpleCrud.{Repo, Exam}

  def index(conn, params) do
    start_date = get_datetime(params["start_date"])
    end_date = get_datetime(params["end_date"], true)
    employee_id = params["employee_id"]

    cond do
      !is_nil(start_date) && !is_nil(end_date) && !is_nil(employee_id) ->
        query = Exam.report_between_dates(start_date, end_date)
        |> Exam.report_employee_id(employee_id)
        |> Exam.report_employee_enabled()

        exams = Repo.all(query)
        render(conn, SimpleCrudWeb.ExamView, "report.json", exams: preload_exam(exams))
      true ->
        conn
        |> put_status(400)
        |> render(SimpleCrudWeb.ErrorView, "query_error.json", message: "Check all search parameters. Something is wrong :(")
    end
  end

  defp preload_exam(exams) do
    Repo.preload(exams, [:client, :employee, :exam_type])
  end

  defp get_datetime(date, end_date? \\ false) do
    option = case end_date? do
      true -> "T23:59:59Z"
      false -> "T00:00:00Z"
    end

    result = case !is_nil(date) && DateTime.from_iso8601(date <> option) do
      {:ok, date, _} ->
        DateTime.to_iso8601(date)
      _ ->
        nil
    end
    result
  end
end