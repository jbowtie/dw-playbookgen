defmodule Playbook.PlaybookController do
  use Playbook.Web, :controller

  alias Playbook.Playbook

  plug :scrub_params, "playbook" when action in [:create, :update]

  def index(conn, _params) do
    playbooks = Repo.all(Playbook)
    render(conn, "index.html", playbooks: playbooks)
  end

  def new(conn, _params) do
    changeset = Playbook.changeset(%Playbook{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"playbook" => playbook_params}) do
    changeset = Playbook.changeset(%Playbook{}, playbook_params)

    case Repo.insert(changeset) do
      {:ok, _playbook} ->
        conn
        |> put_flash(:info, "Playbook created successfully.")
        |> redirect(to: playbook_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    playbook = Repo.get!(Playbook, id)
    render(conn, "show.html", playbook: playbook)
  end

  def edit(conn, %{"id" => id}) do
    playbook = Repo.get!(Playbook, id)
    changeset = Playbook.changeset(playbook)
    render(conn, "edit.html", playbook: playbook, changeset: changeset)
  end

  def update(conn, %{"id" => id, "playbook" => playbook_params}) do
    playbook = Repo.get!(Playbook, id)
    changeset = Playbook.changeset(playbook, playbook_params)

    case Repo.update(changeset) do
      {:ok, playbook} ->
        conn
        |> put_flash(:info, "Playbook updated successfully.")
        |> redirect(to: playbook_path(conn, :show, playbook))
      {:error, changeset} ->
        render(conn, "edit.html", playbook: playbook, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    playbook = Repo.get!(Playbook, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(playbook)

    conn
    |> put_flash(:info, "Playbook deleted successfully.")
    |> redirect(to: playbook_path(conn, :index))
  end
end
