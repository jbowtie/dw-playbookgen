defmodule Playbook.PowerGroupView do
  use Playbook.Web, :view

  def render("index.json", %{power_groups: power_groups}) do
    %{data: render_many(power_groups, Playbook.PowerGroupView, "power_group.json")}
  end

  def render("show.json", %{power_group: power_group}) do
    %{data: render_one(power_group, Playbook.PowerGroupView, "power_group.json")}
  end

  def render("power_group.json", %{power_group: power_group}) do
    %{id: power_group.id,
      title: power_group.title,
      order: power_group.order,
      powerset_id: power_group.powerset_id}
  end
end
