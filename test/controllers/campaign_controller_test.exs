defmodule Playbook.CampaignControllerTest do
  use Playbook.ConnCase

  alias Playbook.Campaign
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, campaign_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing campaigns"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, campaign_path(conn, :new)
    assert html_response(conn, 200) =~ "New campaign"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, campaign_path(conn, :create), campaign: @valid_attrs
    assert redirected_to(conn) == campaign_path(conn, :index)
    assert Repo.get_by(Campaign, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, campaign_path(conn, :create), campaign: @invalid_attrs
    assert html_response(conn, 200) =~ "New campaign"
  end

  test "shows chosen resource", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = get conn, campaign_path(conn, :show, campaign)
    assert html_response(conn, 200) =~ "Show campaign"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, campaign_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = get conn, campaign_path(conn, :edit, campaign)
    assert html_response(conn, 200) =~ "Edit campaign"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = put conn, campaign_path(conn, :update, campaign), campaign: @valid_attrs
    assert redirected_to(conn) == campaign_path(conn, :show, campaign)
    assert Repo.get_by(Campaign, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = put conn, campaign_path(conn, :update, campaign), campaign: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit campaign"
  end

  test "deletes chosen resource", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = delete conn, campaign_path(conn, :delete, campaign)
    assert redirected_to(conn) == campaign_path(conn, :index)
    refute Repo.get(Campaign, campaign.id)
  end
end
