defmodule Playbook.Repo.Migrations.CreatePlaybook do
  use Ecto.Migration

  def change do
    create table(:playbooks) do
      add :name, :string
      add :slug, :string
      add :loadBase, :integer
      add :hpBase, :integer
      add :damageDie, :integer
      add :gear, :text
      add :bonds, :text
      add :nameList, :text

      timestamps
    end

  end
end
