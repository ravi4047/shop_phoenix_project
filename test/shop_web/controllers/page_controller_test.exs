defmodule ShopWeb.PageControllerTest do
  use ShopWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "This is the best video game e-commerce store"

    # =~ Text-based match operator. Matches the term on the left against the regular expression or string on the right.
    # - If right is a regular expression, returns true if left matches right.
    # - If right is a string, returns true if left contains right.

    
  end
end
