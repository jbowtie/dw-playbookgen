defmodule Playbook.CampaignMoveTest do
  use Playbook.ModelCase

  alias Playbook.CampaignMove

  @valid_attrs %{desc: "some content", level: 42, subgroup: "some content", title: "some content", usage: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CampaignMove.changeset(%CampaignMove{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CampaignMove.changeset(%CampaignMove{}, @invalid_attrs)
    refute changeset.valid?
  end
end
