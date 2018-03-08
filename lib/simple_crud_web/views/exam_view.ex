defmodule SimpleCrudWeb.ExamView do
  use SimpleCrudWeb, :view

  def render("index.json", %{exams: exams}) do
    %{data: render_many(exams, SimpleCrudWeb.ExamView, "exam.json")}
  end

  def render("show.json", %{exam: exam}) do
    %{data: render_one(exam, SimpleCrudWeb.ExamView, "exam.json")}
  end

  def render("report.json", %{exams: exams}) do
    %{data: render_many(exams, SimpleCrudWeb.ExamView, "exam.json"), total: Enum.count(exams)}
  end

  def render("exam.json", %{exam: exam}) do
    %{
      id: exam.id,
      entry_date: exam.entry_date,
      price: exam.price,
      client: %{
        id: exam.client.id,
        name: exam.client.name,
        cpf: exam.client.cpf,
        medical_agreement: exam.client.medical_agreement
      },
      employee: %{
        id: exam.employee.id,
        name: exam.employee.name,
        position: exam.employee.position,
        enabled: exam.employee.enabled
      },
      exam_type: %{
        id: exam.exam_type.id,
        name: exam.exam_type.name
      }
    }
  end
end