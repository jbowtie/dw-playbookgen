defmodule Playbook.Repo.Migrations.CreateCampaignMove do
  use Ecto.Migration

  def change do
    create table(:campaign_moves) do
      add :title, :string
      add :usage, :string
      add :desc, :text
      add :level, :integer
      add :subgroup, :string
      add :campaign_id, references(:campaigns)

      timestamps
    end
    create index(:campaign_moves, [:campaign_id])

  end
end
