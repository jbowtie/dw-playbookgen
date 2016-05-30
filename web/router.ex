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


  scope "/admin", Playbook do
    pipe_through :browser # Use the default browser stack
    resources "/playbooks", PlaybookController do
        resources "/moves", MoveController
    end
    resources "/campaigns", CampaignController do
        resources "/moves", CampaignMoveController
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", Playbook do
    pipe_through :api
    resources "/campaign_playbook", CampaignMembershipController, except: [:new, :edit]
    resources "/power_sets", PowerSetController, except: [:new, :edit]
    resources "/power_groups", PowerGroupController, except: [:new, :edit]
    resources "/powers", PowerController, except: [:new, :edit]
  end

  scope "/", Playbook do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :campaigns
    get "/campaigns/", PageController, :campaigns
    get "/campaigns/:slug/", PageController, :playbook_list
    get "/campaigns/:slug/moves", PageController, :moves
    get "/playbooks/:slug/", PageController, :show
  end

end
