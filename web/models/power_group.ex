defmodule Playbook.PowerGroup do
  use Playbook.Web, :model

  schema "power_groups" do
    field :title, :string
    field :order, :integer
    belongs_to :power_set, Playbook.PowerSet
    has_many :powers, Playbook.Power

    timestamps
  end

  @required_fields ~w(title order)
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
