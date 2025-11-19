defmodule ShopWeb.RandomController do

  use ShopWeb, :controller

  # Not every function is an action. To make it action, we use conn, params
  def random(conn, _params) do
    # text(conn, "This is some text") # It returns in text/plain content handling
    # html(conn, "<html><body><h1>This is great</h1></body></html>")
    # json(conn, %{hello: "world"}) ## Under the hood, json uses jason
    render(conn, :random)
  end
end
