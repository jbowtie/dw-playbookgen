defmodule Playbook.CampaignMoveController do
  use Playbook.Web, :controller

  alias Playbook.CampaignMove
  alias Playbook.Campaign

  plug :put_layout, "admin.html"
  plug :scrub_params, "campaign_move" when action in [:create, :update]

  def new(conn, %{"campaign_id" => pbid}) do
    campaign = Repo.get!(Campaign, pbid)
    changeset = CampaignMove.changeset(%CampaignMove{})

    render(conn, "new.html", changeset: changeset, campaign: campaign)
  end

  def new(conn, %{"campaign_id" => pbid, "level" => level}) do
    campaign = Repo.get!(Campaign, pbid)
    changeset = CampaignMove.changeset(%{"level" => level})

    render(conn, "new.html", changeset: changeset, campaign: campaign, level: level)
  end

  def create(conn, %{"campaign_id" => pbid, "campaign_move" => move_params}) do
    campaign = Repo.get!(Campaign, pbid)

    changeset = build_assoc(campaign, :moves)
    |> CampaignMove.changeset(move_params)

    case Repo.insert(changeset) do
      {:ok, _move} ->
        conn
        |> put_flash(:info, "Move created successfully.")
        |> redirect(to: campaign_path(conn, :edit, pbid))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"campaign_id" => pbid, "id" => id}) do
    move = Repo.get!(CampaignMove, id) |> Repo.preload([:campaign])
    changeset = CampaignMove.changeset(move)
    render(conn, "edit.html", move: move, changeset: changeset)
  end

  def update(conn, %{"id" => id, "campaign_move" => move_params}) do
    move = Repo.get!(CampaignMove, id)
    changeset = CampaignMove.changeset(move, move_params)

    case Repo.update(changeset) do
      {:ok, move} ->
        conn
        |> put_flash(:info, "Move updated successfully.")
        |> redirect(to: campaign_path(conn, :edit, move.campaign_id))
      {:error, changeset} ->
        render(conn, "edit.html", move: move, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    move = Repo.get!(CampaignMove, id)

    pb = move.campaign_id
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(move)

    conn
    |> put_flash(:info, "Move deleted successfully.")
    |> redirect(to: campaign_path(conn, :edit, pb))
  end

end
