defmodule Playbook.Playbook do
  use Playbook.Web, :model

  schema "playbooks" do
    field :name, :string
    field :slug, :string
    field :loadBase, :integer
    field :hpBase, :integer
    field :damageDie, :integer
    field :gear, :string
    field :bonds, :string
    field :nameList, :string
    field :option_label, :string
    field :drive_label, :string
    field :summary, :string
    field :look, :string

    has_many :moves, Playbook.Move
    has_many :members, Playbook.CampaignMembership
    has_many :campaigns, through: [:members, :campaign]
    has_one :powerset, Playbook.PowerSet
    timestamps
  end

  @required_fields ~w(name slug loadBase hpBase damageDie gear bonds nameList)
  @optional_fields ~w(option_label drive_label summary look)

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

