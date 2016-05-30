defmodule Playbook.Repo.Migrations.CreatePower do
  use Ecto.Migration

  def change do
    create table(:powers) do
      add :title, :string
      add :usage, :string
      add :desc, :text
      add :powergroup_id, references(:power_groups, on_delete: :nothing)

      timestamps
    end
    create index(:powers, [:powergroup_id])

  end
end
