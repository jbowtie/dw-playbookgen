defmodule Playbook.CampaignMove do
  use Playbook.Web, :model

  schema "campaign_moves" do
    field :title, :string
    field :usage, :string
    field :desc, :string
    field :level, :integer
    field :subgroup, :string
    belongs_to :campaign, Playbook.Campaign, foreign_key: :campaign_id

    timestamps
  end

  @required_fields ~w(title desc level)
  @optional_fields ~w(usage subgroup)

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
