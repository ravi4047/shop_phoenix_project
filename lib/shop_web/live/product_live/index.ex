defmodule ShopWeb.ProductLive.Index do
  use ShopWeb, :live_view

  alias Shop.Products

  def mount(_params, _session, socket) do
    products = Products.list_products()

    likes = products
    |> Enum.map(fn product -> {product.id, 0} end) |> Map.new()

    dbg(likes)

    socket = socket |> assign(:products, products) |> assign(:likes, likes)

    {:ok, socket}
  end

  def handle_event("like", %{"id" => id}, socket) do
    id = String.to_integer(id)
    dbg("Like event triggered")
    dbg(id)
    likes = Map.put(socket.assigns.likes, id, socket.assigns.likes[id] + 1)

    {:noreply, socket |> assign(:likes, likes)}
  end

  # Note we are pushing the diffs when the event is clicked and updated on the socket

  def handle_event("dislike", %{"id" => id}, socket) do
    id = String.to_integer(id)
    dbg("Dislike event triggered")
    dbg(id)
    likes = Map.put(socket.assigns.likes, id, socket.assigns.likes[id] - 1)

    {:noreply, socket |> assign(:likes, likes)}
  end

  def render(assigns) do
    ~H"""
    <h1>Products</h1>
    <ul>
      <%= for product <- @products do %>
        <%!-- <li><%= product.name %> - <%= product.console %></li> --%>
        <li>{product.name} - Likes <%= @likes[product.id] || 0 %></li> <%!-- Using the latest one --%>

        <.icon name="hero-hand-thumb-down-mini" class="size-4 cursor-pointer" phx-click="dislike" phx-value-id={product.id} />
        <.icon name="hero-hand-thumb-up-mini" class="size-4 cursor-pointer" phx-click="like" phx-value-id={product.id} />
      <% end %>
    </ul>
    """
    # In this page we see two LiveView websocket connections. One is for Local development and one is for Production.

# 👉👉 LiveViews have several important lifecycle stages:
# mount - initializes the LiveView with parameters, session data, and socket
# handle_params - responds to URL changes and updates LiveView state accordingly
# handle_event - responds to user interactions coming from the client
# handle_info - responds to regular process messages

# 👉 The LiveView socket is the fundamental data structure that holds all state in a LiveView. It's an immutable structure
# containing "assigns" - the data available to your templates. While controllers have conn, LiveViews have socket.

# 👉 Changes to the socket (via assign/3 or update/3) trigger re-renders. All state is maintained on the server, with only the diffs
# sent to the client, minimizing network traffic.

  end


end
