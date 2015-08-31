defmodule Playbook.MoveController do
  use Playbook.Web, :controller

  alias Playbook.Move
  alias Playbook.Playbook

  plug :put_layout, "admin.html"
  plug :scrub_params, "move" when action in [:create, :update]

  def index(conn, %{"playbook_id" => pbid}) do
    playbook = Repo.get!(Playbook, pbid) |> Repo.preload [:moves]
    render(conn, "index.html", moves: playbook.moves, playbook: playbook)
  end

  def new(conn, %{"playbook_id" => pbid}) do
    playbook = Repo.get!(Playbook, pbid)
    changeset = Move.changeset(%Move{})

    render(conn, "new.html", changeset: changeset, playbook: playbook)
  end

  def create(conn, %{"playbook_id" => pbid, "move" => move_params}) do
    playbook = Repo.get!(Playbook, pbid)

    changeset = build(playbook, :moves)
    |> Move.changeset(move_params)

    case Repo.insert(changeset) do
      {:ok, _move} ->
        conn
        |> put_flash(:info, "Move created successfully.")
        |> redirect(to: playbook_move_path(conn, :index, playbook))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    move = Repo.get!(Move, id) |> Repo.preload [:playbook]
    render(conn, "show.html", move: move)
  end

  def edit(conn, %{"playbook_id" => pbid, "id" => id}) do
    playbook = Repo.get!(Playbook, pbid)
    move = Repo.get!(Move, id)
    changeset = Move.changeset(move)
    render(conn, "edit.html", move: move, changeset: changeset, playbook: playbook)
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    move = Repo.get!(Move, id)
    changeset = Move.changeset(move, move_params)

    case Repo.update(changeset) do
      {:ok, move} ->
        conn
        |> put_flash(:info, "Move updated successfully.")
        |> redirect(to: move_path(conn, :show, move))
      {:error, changeset} ->
        render(conn, "edit.html", move: move, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    move = Repo.get!(Move, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(move)

    conn
    |> put_flash(:info, "Move deleted successfully.")
    |> redirect(to: move_path(conn, :index))
  end

end
