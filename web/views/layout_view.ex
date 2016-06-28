defmodule Playbook.LayoutView do
  use Playbook.Web, :view

  def title do
    "Playbook Admin"
  end
 def page_title(conn, assigns) do
    render_existing(view_module(conn), "page_title",  Dict.put(assigns, :action_name, Phoenix.Controller.action_name(conn)))
      || title
  end
end
