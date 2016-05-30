defmodule Playbook.Repo.Migrations.CreatePowerSet do
  use Ecto.Migration

  def change do
    create table(:power_sets) do
      add :title, :string
      add :playbook_id, references(:playbooks, on_delete: :nothing)

      timestamps
    end
    create index(:power_sets, [:playbook_id])

  end
end
