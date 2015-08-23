defmodule Playbook.PlaybookView do
  use Playbook.Web, :view

  def markdown(txt) do
   {:safe, Earmark.to_html txt}
  end
end
