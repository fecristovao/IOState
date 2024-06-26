defmodule GrowWeb.Router do
  use GrowWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug GrowWeb.PlugMac
  end

  scope "/api", GrowWeb do
    pipe_through :api
    post "/create-device", DeviceController, :create_device
    scope "/v1" do
      pipe_through :auth
      get "/", DeviceController, :index
      patch "/:pin/update", DeviceController, :update_state
      post "/create", DeviceController, :create_state
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:grow, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: GrowWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
