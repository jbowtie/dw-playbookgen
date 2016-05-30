defmodule Playbook.PowerController do
  use Playbook.Web, :controller

  alias Playbook.Power

  plug :scrub_params, "power" when action in [:create, :update]

  def index(conn, _params) do
    powers = Repo.all(Power)
    render(conn, "index.json", powers: powers)
  end

  def create(conn, %{"power" => power_params}) do
    changeset = Power.changeset(%Power{}, power_params)

    case Repo.insert(changeset) do
      {:ok, power} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", power_path(conn, :show, power))
        |> render("show.json", power: power)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    power = Repo.get!(Power, id)
    render(conn, "show.json", power: power)
  end

  def update(conn, %{"id" => id, "power" => power_params}) do
    power = Repo.get!(Power, id)
    changeset = Power.changeset(power, power_params)

    case Repo.update(changeset) do
      {:ok, power} ->
        render(conn, "show.json", power: power)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    power = Repo.get!(Power, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(power)

    send_resp(conn, :no_content, "")
  end
end
