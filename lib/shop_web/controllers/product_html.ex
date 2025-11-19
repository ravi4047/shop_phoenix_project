defmodule ShopWeb.ProductHTML do
  use ShopWeb, :html

  # This one overrides the index.html.heex one.
  # def index(assigns) do
  #   ~H"""
  #   Good boy
  #   """
  # end

  embed_templates "product_html/*"

  # attr :name, :string, required: true
  # def product(assigns) do
  #   ~H"""
  #   <h1>Product component!</h1>
  #   <p>Game: <%= assigns.name %></p>
  #   """
  # end

  ## Using the whole product

  alias Shop.Products.Product

  attr :product, Product, required: true
  def product(assigns) do
    ~H"""
    <.link href={~p"/products/#{@product.slug}"} class="block">{@product.name}</.link>
    """
  end

end
