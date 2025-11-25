defmodule ShopWeb.PromotionController do
  use ShopWeb, :controller

  alias Shop.Promotions
  alias Shop.Promotions.Promotion

  action_fallback ShopWeb.FallbackController

  def index(conn, _params) do
    promotions = Promotions.list_promotions(conn.assigns.current_scope)
    render(conn, :index, promotions: promotions)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    with {:ok, %Promotion{} = promotion} <- Promotions.create_promotion(conn.assigns.current_scope, promotion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/promotions/#{promotion}")
      |> render(:show, promotion: promotion)
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(conn.assigns.current_scope, id)
    render(conn, :show, promotion: promotion)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = Promotions.get_promotion!(conn.assigns.current_scope, id)

    with {:ok, %Promotion{} = promotion} <- Promotions.update_promotion(conn.assigns.current_scope, promotion, promotion_params) do
      render(conn, :show, promotion: promotion)
    end
  end

  def delete(conn, %{"id" => id}) do
    promotion = Promotions.get_promotion!(conn.assigns.current_scope, id)

    with {:ok, %Promotion{}} <- Promotions.delete_promotion(conn.assigns.current_scope, promotion) do
      send_resp(conn, :no_content, "")
    end
  end
end
