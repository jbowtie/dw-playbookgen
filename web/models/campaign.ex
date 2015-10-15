defmodule Playbook.Campaign do
  use Playbook.Web, :model
  
  schema "campaigns" do
    field :name, :string
    field :slug, :string
    field :pitch, :string
    has_many :members, Playbook.CampaignMembership
    has_many :playbooks, through: [:members, :playbook]
    timestamps
  end
end

defmodule Playbook.CampaignMembership do
  use Playbook.Web, :model
  schema "campaign_playbook" do
    belongs_to :campaign, Playbook.Campaign
    belongs_to :playbook, Playbook.Playbook
  end
end
