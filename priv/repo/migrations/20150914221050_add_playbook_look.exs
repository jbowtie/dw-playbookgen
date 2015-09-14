defmodule Playbook.Repo.Migrations.AddPlaybookLook do
  use Ecto.Migration

  def change do
    alter table(:playbooks) do
      add :look, :text
    end
  end
end
