defmodule Playbook.PowerSetController do
  use Playbook.Web, :controller

  alias Playbook.PowerSet

  plug :scrub_params, "power_set" when action in [:create, :update]

  def index(conn, _params) do
    power_sets = Repo.all(PowerSet)
    render(conn, "index.json", power_sets: power_sets)
  end

  def create(conn, %{"power_set" => power_set_params}) do
    changeset = PowerSet.changeset(%PowerSet{}, power_set_params)

    case Repo.insert(changeset) do
      {:ok, power_set} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", power_set_path(conn, :show, power_set))
        |> render("show.json", power_set: power_set)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    power_set = Repo.get!(PowerSet, id)
    render(conn, "show.json", power_set: power_set)
  end

  def update(conn, %{"id" => id, "power_set" => power_set_params}) do
    power_set = Repo.get!(PowerSet, id)
    changeset = PowerSet.changeset(power_set, power_set_params)

    case Repo.update(changeset) do
      {:ok, power_set} ->
        render(conn, "show.json", power_set: power_set)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    power_set = Repo.get!(PowerSet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(power_set)

    send_resp(conn, :no_content, "")
  end
end
