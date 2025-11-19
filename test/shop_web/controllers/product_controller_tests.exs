defmodule ShopWeb.ProductControllerTests do
  use ShopWeb.ConnCase

  alias Shop.ProductsFixtures

  describe "GET /products" do
    test "lists all products", %{conn: conn} do

      product = ProductsFixtures.product_fixture(%{name: "Halo Infinite", console: "xbox"})

      conn = get(conn, ~p"/products")
      assert html_response(conn, 200) =~ product.name
    end
  end

  test "GET /products/:slug shows product details", %{conn: conn} do
    product = ProductsFixtures.product_fixture(%{name: "The Legend of Zelda", console: "switch"})

    conn = get(conn, ~p"/products/#{product.slug}")
    assert html_response(conn, 200) =~ product.name
    assert html_response(conn, 200) =~ to_string(product.console)

  end
end
