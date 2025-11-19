defmodule ShopWeb.CouponJSON do
  alias Shop.Coupons.Coupon

  @doc """
  Renders a list of coupons.
  """
  def index(%{coupons: coupons}) do
    %{data: for(coupon <- coupons, do: data(coupon))}
  end

  @doc """
  Renders a single coupon.
  """
  def show(%{coupon: coupon}) do
    %{data: data(coupon)}
  end

  defp data(%Coupon{} = coupon) do
    %{
      id: coupon.id,
      name: coupon.name,
      code: coupon.code
    }
  end
end
