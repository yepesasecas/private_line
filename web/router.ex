defmodule PrivateLine.Router do
  use PrivateLine.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PrivateLine do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/rommel", PageController, :index
    get "/orders", GetJsonController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PrivateLine do
    pipe_through :api
    get "/orders", GetJsonController, :index
  end
end
