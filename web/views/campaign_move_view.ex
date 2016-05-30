defmodule Playbook.CampaignMoveView do
  use Playbook.Web, :view

  def markdown(txt) do
   {:safe, Earmark.to_html txt}
  end

  def starting(moves) do
    Enum.filter(moves, &(&1.level == 1)) |> Enum.sort_by(&(&1.title))
  end
  def startingaside(moves) do
    Enum.filter(moves, &(&1.level == 0)) |> Enum.sort_by(&(&1.title))
  end
  def advanced(moves) do
    Enum.filter(moves, &(&1.level == 2)) |> Enum.sort_by(&(&1.title))
  end
  def master(moves) do
    Enum.filter(moves, &(&1.level == 6)) |> Enum.sort_by(&(&1.title))
  end
  def motivation(moves) do
    Enum.filter(moves, &(&1.level == 20)) |> Enum.sort_by(&(&1.title))
  end
  def specials(moves) do
    Enum.filter(moves, &(&1.level == 30)) |> Enum.sort_by(&(&1.title))
  end

  def level_desc(-1) do
    "Starting (optional)"
  end
  def level_desc(0) do
    "Starting (aside)"
  end
  def level_desc(1) do
    "Starting"
  end
  def level_desc(2) do
    "Advanced (2-5)"
  end
  def level_desc(6) do
    "Master (6-10)"
  end
  def level_desc(100) do
    "Death"
  end
  def level_desc(30) do
    "Specialization"
  end
  def level_desc(20) do
    "Motivation"
  end
  def level_desc(level) do
    level
  end
end
