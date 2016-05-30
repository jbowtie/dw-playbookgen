defmodule Playbook.PowerGroupController do
  use Playbook.Web, :controller

  alias Playbook.PowerGroup

  plug :scrub_params, "power_group" when action in [:create, :update]

  def index(conn, _params) do
    power_groups = Repo.all(PowerGroup)
    render(conn, "index.json", power_groups: power_groups)
  end

  def create(conn, %{"power_group" => power_group_params}) do
    changeset = PowerGroup.changeset(%PowerGroup{}, power_group_params)

    case Repo.insert(changeset) do
      {:ok, power_group} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", power_group_path(conn, :show, power_group))
        |> render("show.json", power_group: power_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    power_group = Repo.get!(PowerGroup, id)
    render(conn, "show.json", power_group: power_group)
  end

  def update(conn, %{"id" => id, "power_group" => power_group_params}) do
    power_group = Repo.get!(PowerGroup, id)
    changeset = PowerGroup.changeset(power_group, power_group_params)

    case Repo.update(changeset) do
      {:ok, power_group} ->
        render(conn, "show.json", power_group: power_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    power_group = Repo.get!(PowerGroup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(power_group)

    send_resp(conn, :no_content, "")
  end
end
