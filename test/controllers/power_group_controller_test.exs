defmodule Playbook.PowerGroupControllerTest do
  use Playbook.ConnCase

  alias Playbook.PowerGroup
  @valid_attrs %{order: 42, title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, power_group_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    power_group = Repo.insert! %PowerGroup{}
    conn = get conn, power_group_path(conn, :show, power_group)
    assert json_response(conn, 200)["data"] == %{"id" => power_group.id,
      "title" => power_group.title,
      "order" => power_group.order,
      "powerset_id" => power_group.powerset_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, power_group_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, power_group_path(conn, :create), power_group: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PowerGroup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, power_group_path(conn, :create), power_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    power_group = Repo.insert! %PowerGroup{}
    conn = put conn, power_group_path(conn, :update, power_group), power_group: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PowerGroup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    power_group = Repo.insert! %PowerGroup{}
    conn = put conn, power_group_path(conn, :update, power_group), power_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    power_group = Repo.insert! %PowerGroup{}
    conn = delete conn, power_group_path(conn, :delete, power_group)
    assert response(conn, 204)
    refute Repo.get(PowerGroup, power_group.id)
  end
end
