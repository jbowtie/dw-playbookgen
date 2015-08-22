defmodule Playbook.PageController do
  use Playbook.Web, :controller

  alias Playbook.Playbook

  def index(conn, _params) do
    render conn, "index.html"
  end

  def start(conn, _params) do
    render conn, "Bard1.html"
  end

  def show(conn, %{"slug" => slug}) do
    playbook = Repo.get_by!(Playbook, slug: slug)
    render conn, "Playbook.Main.html", book: playbook
  end

  def gear(conn, _params) do
    render conn, "Bard2.html"
  end
end
