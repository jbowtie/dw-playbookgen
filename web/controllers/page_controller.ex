defmodule Playbook.PageController do
  use Playbook.Web, :controller

  alias Playbook.Campaign
  alias Playbook.Playbook

  def index(conn, _params) do
    playbooks = Repo.all(Playbook) |> Enum.sort_by(&(&1.name))
    render conn, "index.html", books: playbooks
  end

  def campaigns(conn, _params) do
    campaigns = Repo.all(Campaign) 
                |> Enum.sort_by(&(&1.name))
                |> Repo.preload([:playbooks])
    render conn, "campaigns.html", campaigns: campaigns
  end

  def playbook_list(conn, %{"slug" => slug}) do
    campaign = Repo.get_by!(Campaign, slug: slug) |> Repo.preload([:playbooks])
    render(conn, "playbooks.html", campaign: campaign, books: campaign.playbooks |> Enum.sort_by(&(&1.name)))
  end

  #  def show(conn, %{"slug" => slug}) do
    #  playbook = Repo.get_by!(Playbook, slug: slug) 
    #   |> Repo.preload([:moves, powerset: [groups: :powers]])
    #render conn, "Playbook.Main.html", book: playbook
    #  end

  def show(conn, %{"campaign" => campaign_slug, "slug" => slug}) do
    campaign = Repo.get_by!(Campaign, slug: campaign_slug) |> Repo.preload([:moves])
    playbook = Repo.get_by!(Playbook, slug: slug) 
      |> Repo.preload([:moves, powerset: [groups: :powers]])
    conn
      |> render("Playbook.Main.html", book: playbook, campaign: campaign)
  end

  def print(conn, %{"slug" => slug}) do
    playbook = Repo.get_by!(Playbook, slug: slug) 
      |> Repo.preload([:moves, powerset: [groups: :powers]])
    conn
      |> put_layout("print.html")
      |> render("Playbook.Print.html", book: playbook)
  end

  def moves(conn, %{"slug" => slug}) do
    campaign = Repo.get_by!(Campaign, slug: slug) |> Repo.preload([:moves])
    render conn, "Campaign.Moves.html", campaign: campaign
  end
end
