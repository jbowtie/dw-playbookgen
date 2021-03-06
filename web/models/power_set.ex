defmodule Playbook.PowerSet do
  use Playbook.Web, :model

  schema "power_sets" do
    field :title, :string
    belongs_to :playbook, Playbook.Playbook
    has_many :groups, Playbook.PowerGroup

    timestamps
  end

  @required_fields ~w(title)
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
