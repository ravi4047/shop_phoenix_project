defmodule Shop.Coupons.Coupon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "coupons" do
    field :name, :string
    field :code, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(coupon, attrs) do
    coupon
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
    |> unique_constraint(:code)
  end
end
