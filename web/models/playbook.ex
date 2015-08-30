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

    has_many :moves, Playbook.Move
    timestamps
  end

  @required_fields ~w(name slug loadBase hpBase damageDie gear bonds nameList)
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

# add pitch (text)
# Option label (string); default RACE
# Drive label (string); default ALIGNMENT
# -1 unticked level 1
# 1 starting
# 2 advanced
# 6 master
# -2 option
# -3 drive
# 0 special
# 100 death
