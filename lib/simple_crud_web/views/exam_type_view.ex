defmodule SimpleCrudWeb.ExamTypeView do
  use SimpleCrudWeb, :view

  def render("index.json", %{exam_types: exam_types}) do
    %{data: render_many(exam_types, SimpleCrudWeb.ExamTypeView, "exam_type.json")}
  end

  def render("show.json", %{exam_type: exam_type}) do
    %{data: render_one(exam_type, SimpleCrudWeb.ExamTypeView, "exam_type.json")}
  end

  def render("exam_type.json", %{exam_type: exam_type}) do
    %{
      id: exam_type.id,
      name: exam_type.name
    }
  end
end