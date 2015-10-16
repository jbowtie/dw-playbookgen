defmodule Playbook.CampaignMembershipView do
  use Playbook.Web, :view

  def render("index.json", %{campaign_playbook: campaign_playbook}) do
    %{data: render_many(campaign_playbook, Playbook.CampaignMembershipView, "campaign_membership.json")}
  end

  def render("show.json", %{campaign_membership: campaign_membership}) do
    %{data: render_one(campaign_membership, Playbook.CampaignMembershipView, "campaign_membership.json")}
  end

  def render("campaign_membership.json", %{campaign_membership: campaign_membership}) do
    %{id: campaign_membership.id,
      campaign_id: campaign_membership.campaign_id,
      playbook_id: campaign_membership.playbook_id}
  end
end
