defmodule ShopWeb.PageController do
  use ShopWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # dbg(conn)
    render(conn, :home, layout: false) # :home is the template name for the view template
    # layout: false disables the default layout for this render
  end
end

# mix phx.server to run the server
