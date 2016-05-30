defmodule Playbook.PowerSetTest do
  use Playbook.ModelCase

  alias Playbook.PowerSet

  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PowerSet.changeset(%PowerSet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PowerSet.changeset(%PowerSet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
