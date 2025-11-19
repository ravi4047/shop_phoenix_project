defmodule ShopWeb.ProductLive.ProductLiveTest do
  use ShopWeb.ConnCase

  # import Phoenix.LiveViewTest # Already imported inside ShopWeb.ConnCase

  import Shop.ProductsFixtures

  # describe "index" do
  #   test "lists all products", %{conn: conn} do
  #     {:ok, view, _html} = live(conn, ~p"/products-live")

  #     assert has_element?(view, "h1", "Products")
  #     assert has_element?(view, "ul li", count: 3)
  #   end
  # end

  test "LIVE /products-live", %{conn: conn} do
    product = product_fixture()

    assert {:ok, product_live_view, html} = live(conn, ~p"/products-live")
    dbg(html)
    assert html =~ "#{product.name} - Likes 0"

    ## To handle the events, we do
    html = render_click(product_live_view, :like, %{"id"=>to_string(product.id)})
    assert html =~ "#{product.name} - Likes 1"

    ## Let's dislike it
    html = render_click(product_live_view, :dislike, %{"id"=>to_string(product.id)})
    assert html =~ "#{product.name} - Likes 0"
  end
end
