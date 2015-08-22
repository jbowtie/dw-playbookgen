defmodule Playbook.PlaybookTest do
  use Playbook.ModelCase

  alias Playbook.Playbook

  @valid_attrs %{bonds: "some content", damageDie: 42, gear: "some content", hpBase: 42, loadBase: 42, name: "some content", nameList: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Playbook.changeset(%Playbook{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Playbook.changeset(%Playbook{}, @invalid_attrs)
    refute changeset.valid?
  end
end
