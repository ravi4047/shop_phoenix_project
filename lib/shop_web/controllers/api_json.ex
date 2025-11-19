defmodule ShopWeb.ApiJSON do

  # 👉👉 Here, now instead of calling regular ApiHTML, we do with ApiJSON.

  # 👉 def index(assigns) do # Or use elixir pattern matching
  def index(%{products: products}) do
    %{products: products}
  end

  # 👉 protocol Jason.Encoder not implemented for type Shop.Products.Product (a struct), Jason.Encoder protocol must always be explicitly implemented.

  # 👉 Solution: Use Jason.Encoder in Schema.

end
