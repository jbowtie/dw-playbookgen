defmodule Playbook.CampaignView do
  use Playbook.Web, :view

  def markdown(txt) do
   {:safe, Earmark.to_html txt}
  end
  def starting(moves) do
    Enum.filter(moves, &(&1.level == 1)) |> Enum.sort_by(&(&1.title))
  end
  def advanced(moves) do
    Enum.filter(moves, &(&1.level == 2)) |> Enum.sort_by(&(&1.title))
  end
end
