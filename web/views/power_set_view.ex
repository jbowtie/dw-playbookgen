defmodule Playbook.PowerSetView do
  use Playbook.Web, :view

  def render("index.json", %{power_sets: power_sets}) do
    %{data: render_many(power_sets, Playbook.PowerSetView, "power_set.json")}
  end

  def render("show.json", %{power_set: power_set}) do
    %{data: render_one(power_set, Playbook.PowerSetView, "power_set.json")}
  end

  def render("power_set.json", %{power_set: power_set}) do
    %{id: power_set.id,
      title: power_set.title,
      playbook_id: power_set.playbook_id}
  end
end
