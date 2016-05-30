defmodule Playbook.Campaign do
  use Playbook.Web, :model
  
  schema "campaigns" do
    field :name, :string
    field :slug, :string
    field :pitch, :string
    has_many :members, Playbook.CampaignMembership
    has_many :playbooks, through: [:members, :playbook]
    has_many :moves, Playbook.CampaignMove

    timestamps
  end
  @required_fields ~w(name slug pitch)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

defmodule Playbook.CampaignMembership do
  use Playbook.Web, :model
  schema "campaign_playbook" do
    belongs_to :campaign, Playbook.Campaign
    belongs_to :playbook, Playbook.Playbook
  end
end
