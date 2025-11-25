defmodule Shop.Promotions.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :name, :string
    field :code, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(promotion, attrs, user_scope) do
    promotion
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
    |> put_change(:user_id, user_scope.user.id)
  end
end
