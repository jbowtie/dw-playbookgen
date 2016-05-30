defmodule Playbook.PowerSetControllerTest do
  use Playbook.ConnCase

  alias Playbook.PowerSet
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, power_set_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    power_set = Repo.insert! %PowerSet{}
    conn = get conn, power_set_path(conn, :show, power_set)
    assert json_response(conn, 200)["data"] == %{"id" => power_set.id,
      "title" => power_set.title,
      "playbook_id" => power_set.playbook_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, power_set_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, power_set_path(conn, :create), power_set: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PowerSet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, power_set_path(conn, :create), power_set: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    power_set = Repo.insert! %PowerSet{}
    conn = put conn, power_set_path(conn, :update, power_set), power_set: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PowerSet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    power_set = Repo.insert! %PowerSet{}
    conn = put conn, power_set_path(conn, :update, power_set), power_set: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    power_set = Repo.insert! %PowerSet{}
    conn = delete conn, power_set_path(conn, :delete, power_set)
    assert response(conn, 204)
    refute Repo.get(PowerSet, power_set.id)
  end
end
