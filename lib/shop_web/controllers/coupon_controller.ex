defmodule ShopWeb.CouponController do
  use ShopWeb, :controller

  alias Shop.Coupons
  alias Shop.Coupons.Coupon

  action_fallback ShopWeb.FallbackController

  def index(conn, _params) do
    coupons = Coupons.list_coupons()
    render(conn, :index, coupons: coupons)
  end

  def create(conn, %{"coupon" => coupon_params}) do
    with {:ok, %Coupon{} = coupon} <- Coupons.create_coupon(coupon_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/coupons/#{coupon}")
      |> render(:show, coupon: coupon)
    end
  end

  def show(conn, %{"id" => id}) do
    coupon = Coupons.get_coupon!(id)
    render(conn, :show, coupon: coupon)
  end

  def update(conn, %{"id" => id, "coupon" => coupon_params}) do
    coupon = Coupons.get_coupon!(id)

    with {:ok, %Coupon{} = coupon} <- Coupons.update_coupon(coupon, coupon_params) do
      render(conn, :show, coupon: coupon)
    end
  end

  def delete(conn, %{"id" => id}) do
    coupon = Coupons.get_coupon!(id)

    with {:ok, %Coupon{}} <- Coupons.delete_coupon(coupon) do
      send_resp(conn, :no_content, "")
    end
  end
end
