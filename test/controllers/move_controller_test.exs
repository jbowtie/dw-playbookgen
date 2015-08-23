defmodule Playbook.MoveControllerTest do
  use Playbook.ConnCase

  alias Playbook.Move
  @valid_attrs %{desc: "some content", level: 42, title: "some content", usage: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, move_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing moves"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, move_path(conn, :new)
    assert html_response(conn, 200) =~ "New move"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, move_path(conn, :create), move: @valid_attrs
    assert redirected_to(conn) == move_path(conn, :index)
    assert Repo.get_by(Move, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, move_path(conn, :create), move: @invalid_attrs
    assert html_response(conn, 200) =~ "New move"
  end

  test "shows chosen resource", %{conn: conn} do
    move = Repo.insert! %Move{}
    conn = get conn, move_path(conn, :show, move)
    assert html_response(conn, 200) =~ "Show move"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, move_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    move = Repo.insert! %Move{}
    conn = get conn, move_path(conn, :edit, move)
    assert html_response(conn, 200) =~ "Edit move"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    move = Repo.insert! %Move{}
    conn = put conn, move_path(conn, :update, move), move: @valid_attrs
    assert redirected_to(conn) == move_path(conn, :show, move)
    assert Repo.get_by(Move, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    move = Repo.insert! %Move{}
    conn = put conn, move_path(conn, :update, move), move: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit move"
  end

  test "deletes chosen resource", %{conn: conn} do
    move = Repo.insert! %Move{}
    conn = delete conn, move_path(conn, :delete, move)
    assert redirected_to(conn) == move_path(conn, :index)
    refute Repo.get(Move, move.id)
  end
end
