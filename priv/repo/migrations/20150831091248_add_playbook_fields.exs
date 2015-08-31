defmodule Playbook.Repo.Migrations.AddPlaybookFields do
  use Ecto.Migration

  def change do
    alter table(:playbooks) do
      add :option_label, :string
      add :drive_label, :string
      add :summary, :text
    end
  end
end
