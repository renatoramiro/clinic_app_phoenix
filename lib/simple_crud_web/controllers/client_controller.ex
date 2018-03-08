defmodule SimpleCrudWeb.ClientController do
  use SimpleCrudWeb, :controller
  alias SimpleCrud.{Repo, Client}

  plug :scrub_params, "client" when action in [:create, :update]

  def index(conn, _params) do
    clients = Repo.all(Client)
    render(conn, "index.json", clients: clients)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Client, id) do
      client = %Client{} ->
        render(conn, "show.json", client: client)
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Client not found!")
    end
  end

  def create(conn, %{"client" => params}) do
    changeset = Client.changeset(%Client{}, params)
    case Repo.insert(changeset) do
      {:ok, client} ->
        render(conn, "show.json", client: client)
      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "client" => params}) do
    with client = %Client{} <- Repo.get(Client, id) do
      changeset = Client.changeset(client, params)
      case Repo.update(changeset) do
        {:ok, client} ->
          render(conn, "show.json", client: client)
        {:error, changeset} ->
          conn
          |> put_status(400)
          |> render(SimpleCrudWeb.ErrorView, "400.json", changeset: changeset)
      end
    else
      nil ->
        conn
        |> put_status(404)
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Client not found!")
    end
  end

  def delete(conn, %{"id" => id}) do
    with client = %Client{} <- Repo.get(Client, id) do
      case Repo.delete(client) do
        {:ok, _client} ->
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
        |> render(SimpleCrudWeb.ErrorView, "404.json", message: "Client not found!")
    end
  end
end