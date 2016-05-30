defmodule Playbook.CampaignController do
  use Playbook.Web, :controller

  alias Playbook.Campaign

  plug :put_layout, "admin.html"
  plug :scrub_params, "campaign" when action in [:create, :update]

  def index(conn, _params) do
    campaigns = Repo.all(Campaign)
    render(conn, "index.html", campaigns: campaigns)
  end

  def new(conn, _params) do
    changeset = Campaign.changeset(%Campaign{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"campaign" => campaign_params}) do
    changeset = Campaign.changeset(%Campaign{}, campaign_params)

    case Repo.insert(changeset) do
      {:ok, _campaign} ->
        conn
        |> put_flash(:info, "Campaign created successfully.")
        |> redirect(to: campaign_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    campaign = Repo.get!(Campaign, id) |> Repo.preload([:playbooks])
    render(conn, "show.html", campaign: campaign)
  end

  def edit(conn, %{"id" => id}) do
    campaign = Repo.get!(Campaign, id) |> Repo.preload([:playbooks, :moves])
    changeset = Campaign.changeset(campaign)
    render(conn, "edit.html", campaign: campaign, changeset: changeset)
  end

  def update(conn, %{"id" => id, "campaign" => campaign_params}) do
    campaign = Repo.get!(Campaign, id)
    changeset = Campaign.changeset(campaign, campaign_params)

    case Repo.update(changeset) do
      {:ok, campaign} ->
        conn
        |> put_flash(:info, "Campaign updated successfully.")
        |> redirect(to: campaign_path(conn, :show, campaign))
      {:error, changeset} ->
        render(conn, "edit.html", campaign: campaign, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    campaign = Repo.get!(Campaign, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(campaign)

    conn
    |> put_flash(:info, "Campaign deleted successfully.")
    |> redirect(to: campaign_path(conn, :index))
  end
end
