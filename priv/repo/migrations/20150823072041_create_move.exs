defmodule Playbook.Repo.Migrations.CreateMove do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :title, :string
      add :usage, :string
      add :desc, :text
      add :level, :integer
      add :playbook_id, references(:playbooks)

      timestamps
    end
    create index(:moves, [:playbook_id])

  end
end
