defmodule Playbook.PageController do
  use Playbook.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def start(conn, _params) do
    render conn, "Bard1.html"
  end

  def gear(conn, _params) do
    render conn, "Bard2.html"
  end
end
