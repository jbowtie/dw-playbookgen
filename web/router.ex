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


    get "/:slug/", PageController, :show
    get "/:slug/adv/", PageController, :gear
  end


  scope "/admin", Playbook do
    pipe_through :browser # Use the default browser stack
    resources "/playbooks", PlaybookController do
        resources "/moves", MoveController
    end
    resources "/moves", MoveController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Playbook do
  #   pipe_through :api
  # end
end
