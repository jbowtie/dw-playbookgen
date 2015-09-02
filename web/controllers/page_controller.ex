defmodule Playbook.PageController do
  use Playbook.Web, :controller

  alias Playbook.Playbook

  def index(conn, _params) do
    playbooks = Repo.all(Playbook) |> Enum.sort_by(&(&1.name))
    render conn, "index.html", books: playbooks
  end

  def show(conn, %{"slug" => slug}) do
    playbook = Repo.get_by!(Playbook, slug: slug) |> Repo.preload [:moves]
    render conn, "Playbook.Main.html", book: playbook
  end

  def gear(conn, %{"slug" => slug}) do
    playbook = Repo.get_by!(Playbook, slug: slug) |> Repo.preload [:moves]
    render conn, "Playbook.Page2.html", book: playbook
  end
end
