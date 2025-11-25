defmodule Shop.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :name, :string
      add :code, :string
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:promotions, [:user_id])

    create unique_index(:promotions, [:code])
  end
end
