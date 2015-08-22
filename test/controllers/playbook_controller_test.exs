defmodule Playbook.PlaybookControllerTest do
  use Playbook.ConnCase

  alias Playbook.Playbook
  @valid_attrs %{bonds: "some content", damageDie: 42, gear: "some content", hpBase: 42, loadBase: 42, name: "some content", nameList: "some content", slug: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, playbook_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing playbooks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, playbook_path(conn, :new)
    assert html_response(conn, 200) =~ "New playbook"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, playbook_path(conn, :create), playbook: @valid_attrs
    assert redirected_to(conn) == playbook_path(conn, :index)
    assert Repo.get_by(Playbook, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, playbook_path(conn, :create), playbook: @invalid_attrs
    assert html_response(conn, 200) =~ "New playbook"
  end

  test "shows chosen resource", %{conn: conn} do
    playbook = Repo.insert! %Playbook{}
    conn = get conn, playbook_path(conn, :show, playbook)
    assert html_response(conn, 200) =~ "Show playbook"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, playbook_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    playbook = Repo.insert! %Playbook{}
    conn = get conn, playbook_path(conn, :edit, playbook)
    assert html_response(conn, 200) =~ "Edit playbook"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    playbook = Repo.insert! %Playbook{}
    conn = put conn, playbook_path(conn, :update, playbook), playbook: @valid_attrs
    assert redirected_to(conn) == playbook_path(conn, :show, playbook)
    assert Repo.get_by(Playbook, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    playbook = Repo.insert! %Playbook{}
    conn = put conn, playbook_path(conn, :update, playbook), playbook: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit playbook"
  end

  test "deletes chosen resource", %{conn: conn} do
    playbook = Repo.insert! %Playbook{}
    conn = delete conn, playbook_path(conn, :delete, playbook)
    assert redirected_to(conn) == playbook_path(conn, :index)
    refute Repo.get(Playbook, playbook.id)
  end
end
