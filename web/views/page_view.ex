defmodule Playbook.PageView do
  use Playbook.Web, :view

  def markdown(txt) do
   {:safe, Earmark.to_html txt}
  end

  def starting(moves) do
    Enum.filter(moves, &(&1.level == 1))
  end
end
