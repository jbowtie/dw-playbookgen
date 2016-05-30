defmodule Playbook.PowerTest do
  use Playbook.ModelCase

  alias Playbook.Power

  @valid_attrs %{desc: "some content", title: "some content", usage: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Power.changeset(%Power{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Power.changeset(%Power{}, @invalid_attrs)
    refute changeset.valid?
  end
end
