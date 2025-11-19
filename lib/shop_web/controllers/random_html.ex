# How we create the file if want to use html
# Then we do {module}_{format}.ex

## If html then random_html.ex, if json then random_json.ex and so on.

defmodule ShopWeb.RandomHTML do
  use ShopWeb, :html

  # Here we will not use embed templates, but simply inline one
  def random(assigns) do
    ~H"""
    <h1>I am insidde Random page</h1>
    """
  end
end
