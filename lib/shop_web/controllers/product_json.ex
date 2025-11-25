defmodule ShopWeb.ProductJSON do
  # You don't need any macro here

  ## To render this json one, do $ localhost:4000/products?_format=json # this is a hidden query param

  # 👉👉 Ideally we have separate scope for api json stuff

  # def index(_assigns) do
  #   %{data: [
  #     %{name: "God of war"},
  #     %{name: "Skyrim"},
  #     %{name: "Diablo 4"}
  #   ]}
  # end
  def index(%{products: products}) do
    %{data: products}
  end
end
