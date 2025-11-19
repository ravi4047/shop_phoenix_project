defmodule Shop.Repo.Migrations.CreateCoupons do
  use Ecto.Migration

  def change do
    create table(:coupons) do
      add :name, :string
      add :code, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:coupons, [:code])
  end
end
