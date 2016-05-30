defmodule Playbook.PowerControllerTest do
  use Playbook.ConnCase

  alias Playbook.Power
  @valid_attrs %{desc: "some content", title: "some content", usage: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, power_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    power = Repo.insert! %Power{}
    conn = get conn, power_path(conn, :show, power)
    assert json_response(conn, 200)["data"] == %{"id" => power.id,
      "title" => power.title,
      "usage" => power.usage,
      "desc" => power.desc,
      "powergroup_id" => power.powergroup_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, power_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, power_path(conn, :create), power: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Power, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, power_path(conn, :create), power: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    power = Repo.insert! %Power{}
    conn = put conn, power_path(conn, :update, power), power: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Power, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    power = Repo.insert! %Power{}
    conn = put conn, power_path(conn, :update, power), power: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    power = Repo.insert! %Power{}
    conn = delete conn, power_path(conn, :delete, power)
    assert response(conn, 204)
    refute Repo.get(Power, power.id)
  end
end
