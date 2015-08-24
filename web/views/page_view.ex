defmodule Playbook.PageView do
  use Playbook.Web, :view

  def markdown(txt) do
   {:safe, Earmark.to_html txt}
  end

  def starting(moves) do
    Enum.filter(moves, &(&1.level == 1))
  end
  def advanced(moves) do
    Enum.filter(moves, &(&1.level == 2))
  end
  def master(moves) do
    Enum.filter(moves, &(&1.level == 6))
  end
end
