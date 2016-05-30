defmodule Playbook.PowerView do
  use Playbook.Web, :view

  def render("index.json", %{powers: powers}) do
    %{data: render_many(powers, Playbook.PowerView, "power.json")}
  end

  def render("show.json", %{power: power}) do
    %{data: render_one(power, Playbook.PowerView, "power.json")}
  end

  def render("power.json", %{power: power}) do
    %{id: power.id,
      title: power.title,
      usage: power.usage,
      desc: power.desc,
      powergroup_id: power.powergroup_id}
  end
end
