defmodule ShopWeb.ProductController do
  use ShopWeb, :controller

  # 👉👉 To convert the any function into action, it should accept two parameters, connection and option


  # This is Copilot generated stuff.

  # alias Shop.Catalog
  # alias Shop.Catalog.Product

  # 👉 (Me) - AFAIR, Catalog is the context one.
  # mix phx.gen.context Catalog Product categories title:string:unique

  # But what's the use of context here do you remember??
  # I mean they create bunch of things including in the database

  # 👉👉 This products is called a module attribute.
  # @products [
  #   %{id: "1", name: "God of war"},
  #   %{id: "2", name: "Skyrim"},
  #   %{id: "3", name: "Diablo 4"}
  # ]

  # alias Shop.{Repo, Product}
  # alias Shop.Repo
  # alias Shop.Products.Product

  alias Shop.Products

  @doc """
  This is used to show the list of all items
  """
  def index(conn, _params) do
    # products = Catalog.list_products()
    # render(conn, "index.html", products: products)
    # dbg(conn)

    # render(conn, "index.html")


    # conn
    # # |> redirect(to: ~p"wroong")
    # |> redirect(to: ~p"wroong")

    # 👉 <%!-- In the view and controller the verified routes are auto imported. --%>

    # conn
    # |> assign(:products, @products)
    # |> render(:index)

    # 👉 Using Ecto: Repo query
    # products = Repo.all(Product) ## 👉👉 Don't call the Repo directly from controller. Use contexts.


    products = Products.list_products()
    dbg(products)
    conn
    |> assign(:products, products)
    |> render(:index)
  end

  # def show(conn, %{"id" => id}) do # This is elixir way rather than just passing params
  #   # product = Catalog.get_product!(id)
  #   dbg(id) ##

  #   # render(conn, "show.html", product: product)
  #   # render(conn, "show.html", id: id, name: "ravi") # 👉 The assigns is similar to props of React. It's a keyword list where keys are atoms


  #   # product = Enum.find(@products, fn product -> product.id == id end)

  #   # Using Ecto: Repo query
  #   product = Repo.get(Product, id)

  #   # 👉👉👉 Don't query the DB inside controllers. Use contexts.
  #   # This mixture of business logic and the view layer should not happen. (View layer is controller + view)

  #   conn
  #   |> assign(:product, product)
  #   |> render(:show)
  # end

  def show(conn, %{"slug" => slug}) do
    # product = Repo.get_by(Product, slug: slug)
    product = Products.find_product_by_slug(slug)

    conn
    |> assign(:product, product)
    |> render(:show)
  end

end
