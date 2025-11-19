defmodule ShopWeb.Plugs.SetConsole do
  # How to make this a module plug? We need 2 functions. init and call
  # - init - To handle opts
  # - call - for heavylifting of the stuff

  import Plug.Conn

  # Attributes
  @valid_consoles ["pc", "ps5", "xbox", "switch"]

  def init(default_console), do: default_console

  # 👉👉 Note, we will first persist this option selection in cookies

  def call(%Plug.Conn{:params => %{"console" => console}} = conn, _default_console) when console in @valid_consoles do
    # We are using guards here.

    IO.inspect("Module plug is working")

    IO.inspect("OPTS: " <> _default_console)

    conn # Since it's a plug (middleware), we need to return the conn
    |> assign(:console, console)
    |> put_resp_cookie("console", console, max_age: :timer.hours(24)*30)
  end

  # Reading from the cookies
  def call(%Plug.Conn{:cookies => %{"console" => console}} = conn, _default_console) when console in @valid_consoles do
    conn # Since it's a plug (middleware), we need to return the conn
    |> assign(:console, console)
  end

  ## If cookies,

  # By default, we will persist in default_console
  def call(%Plug.Conn{} = conn, default_console) do
    conn # Since it's a plug (middleware), we need to return the conn
    |> assign(:console, default_console)
    |> put_resp_cookie("console", default_console, max_age: :timer.hours(24)*30)
  end
end
