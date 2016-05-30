defmodule Playbook.Power do
  use Playbook.Web, :model

  schema "powers" do
    field :title, :string
    field :usage, :string
    field :desc, :string
    belongs_to :powergroup, Playbook.Powergroup

    timestamps
  end

  @required_fields ~w(title usage desc)
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
