defmodule Playbook.MoveTest do
  use Playbook.ModelCase

  alias Playbook.Move

  @valid_attrs %{desc: "some content", level: 42, title: "some content", usage: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Move.changeset(%Move{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Move.changeset(%Move{}, @invalid_attrs)
    refute changeset.valid?
  end
end
