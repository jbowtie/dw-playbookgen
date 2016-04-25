defmodule Playbook.PlaybookView do
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
end
