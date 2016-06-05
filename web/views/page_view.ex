defmodule Playbook.PageView do
  use Playbook.Web, :view

  def markdown(txt) do
    output = txt 
    |> String.replace("[xxx]", "\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_")
    |> Earmark.to_html
   {:safe, output}
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



  def basic(moves) do
    Enum.filter(moves, &(&1.level == 1 && &1.subgroup == nil)) |> Enum.sort_by(&(&1.title))
  end

  def basic_groups(moves) do
    Enum.filter(moves, &(&1.level == 1 && &1.subgroup != nil)) 
      |> Enum.group_by(&(&1.subgroup))
      |> Map.keys
  end

  def group(moves, key) do
    Enum.filter(moves, &(&1.subgroup == key))
      |> Enum.sort_by(&(&1.title))
  end
end
