defmodule LunchDatastore.Database.Repo.Migrations.CreateDb do
  use Ecto.Migration

  def change do
    create table(:party) do
      add(:name, :string, null: false)
      timestamps()
    end

    create table(:user) do
      add(:name, :string, null: false)
      timestamps()
    end

    create unique_index(:user, [:name])


    create table(:party_user) do
      add(:party_id, references(:party), null: false)
      add(:user_id,  references(:user),  null: false)
      timestamps()
    end

    create unique_index(:party_user, [:party_id, :user_id])


    create table(:party_alternative) do
      add(:alternative, :string, null: false)
      add(:party_id, references(:party), null: false)
      timestamps()
    end

    create table(:chosen_alternative) do
      add(:alternative, :string, null: false)
      add(:party_id, references(:party), null: false)
      timestamps()
    end
  end
end
