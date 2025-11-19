defmodule ShopWeb.Router do
  # alias ShopWeb.ProductController
  use ShopWeb, :router

  import ShopWeb.UserAuth

  alias ShopWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ShopWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user

    plug Plugs.SetConsole, "pc"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Custom pipeline with custom plug
  # pipeline :auth do
  #   plug Plugs.EnsureAuthenticated
  # end

  scope "/", ShopWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/products", ProductController, :index
    # get "/products/random", ProductController, :random
    # get "/products/:id", ProductController, :show
    get "/products/:slug", ProductController, :show

    ## 👉👉 Using resources
    # resources "/products", ProductController, only: [:index, :show]
    # resources "/products", ProductController, except: [:delete]

    # 👉👉 Using nested routes
    # resources "/users", UserController do
    #   get "/posts", PostController, :index
    # end

    get "/random", RandomController, :random

    resources "/promotions", PromotionController

    live "/product-live", ProductLive.Index, :index

  end

  # Other scopes may use custom stacks.
  scope "/api", ShopWeb do
    pipe_through :api

    get "/products", ApiController, :index

    resources "/coupons", CouponController, except: [:new, :edit]
  end

  ### Dashboard
  # scope "/dashboard", ShopWeb do
  #   pipe_through [:browser, :auth] # Here we used multiple pipelines

  #   get "/", DashboardController, :index
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:shop, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ShopWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", ShopWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{ShopWeb.UserAuth, :require_authenticated}] do
      live "/users/settings", UserLive.Settings, :edit
      live "/users/settings/confirm-email/:token", UserLive.Settings, :confirm_email
    end

    post "/users/update-password", UserSessionController, :update_password
  end

  scope "/", ShopWeb do
    pipe_through [:browser]

    live_session :current_user,
      on_mount: [{ShopWeb.UserAuth, :mount_current_scope}] do
      live "/users/register", UserLive.Registration, :new
      live "/users/log-in", UserLive.Login, :new
      live "/users/log-in/:token", UserLive.Confirmation, :new
    end

    post "/users/log-in", UserSessionController, :create
    delete "/users/log-out", UserSessionController, :delete
  end

end
