defmodule Playbook.CampaignMembershipController do
  use Playbook.Web, :controller

  alias Playbook.CampaignMembership

  plug :scrub_params, "campaign_membership" when action in [:create, :update]

  def index(conn, _params) do
    campaign_playbook = Repo.all(CampaignMembership)
    render(conn, "index.json", campaign_playbook: campaign_playbook)
  end

  def create(conn, %{"campaign_membership" => campaign_membership_params}) do
    changeset = CampaignMembership.changeset(%CampaignMembership{}, campaign_membership_params)

    case Repo.insert(changeset) do
      {:ok, campaign_membership} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", campaign_membership_path(conn, :show, campaign_membership))
        |> render("show.json", campaign_membership: campaign_membership)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    campaign_membership = Repo.get!(CampaignMembership, id)
    render(conn, "show.json", campaign_membership: campaign_membership)
  end

  def update(conn, %{"id" => id, "campaign_membership" => campaign_membership_params}) do
    campaign_membership = Repo.get!(CampaignMembership, id)
    changeset = CampaignMembership.changeset(campaign_membership, campaign_membership_params)

    case Repo.update(changeset) do
      {:ok, campaign_membership} ->
        render(conn, "show.json", campaign_membership: campaign_membership)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Playbook.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    campaign_membership = Repo.get!(CampaignMembership, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(campaign_membership)

    send_resp(conn, :no_content, "")
  end
end
