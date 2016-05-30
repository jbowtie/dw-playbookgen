defmodule Playbook.Repo.Migrations.CreatePowerGroup do
  use Ecto.Migration

  def change do
    create table(:power_groups) do
      add :title, :string
      add :order, :integer
      add :powerset_id, references(:power_sets, on_delete: :nothing)

      timestamps
    end
    create index(:power_groups, [:powerset_id])

  end
end
