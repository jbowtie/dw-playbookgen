defmodule Playbook.Router do
  use Playbook.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Playbook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/bard", PageController, :start
    get "/bard/2", PageController, :gear

    resources "/playbooks", PlaybookController

    get "/:slug/", PageController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Playbook do
  #   pipe_through :api
  # end
end
