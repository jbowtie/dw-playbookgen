defmodule Playbook.Router do
  use Playbook.Web, :router

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

  scope "/", Playbook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/campaigns/", PageController, :campaigns

    get "/:slug/", PageController, :show
  end


  scope "/admin", Playbook do
    pipe_through :browser # Use the default browser stack
    resources "/playbooks", PlaybookController do
        resources "/moves", MoveController
    end
    resources "/moves", MoveController
    resources "/campaigns", CampaignController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Playbook do
  #   pipe_through :api
  # end
end
