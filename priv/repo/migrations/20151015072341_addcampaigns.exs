defmodule Playbook.Repo.Migrations.Addcampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string
      add :slug, :string
      add :pitch, :string
      timestamps
    end
    create table(:campaign_playbook) do
      add :campaign_id, references(:campaigns)
      add :playbook_id, references(:playbooks)
    end
    create index(:campaign_playbook, [:playbook_id])
    create index(:campaign_playbook, [:campaign_id])
  end
end
