defmodule SimpleCrudWeb.ClientView do
  use SimpleCrudWeb, :view

  def render("index.json", %{clients: clients}) do
    %{data: render_many(clients, SimpleCrudWeb.ClientView, "client.json")}
  end

  def render("show.json", %{client: client}) do
    %{data: render_one(client, SimpleCrudWeb.ClientView, "client.json")}
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      name: client.name,
      medical_agreement: client.medical_agreement,
      cpf: client.cpf
    }
  end
end