defmodule Playbook.CampaignMembershipControllerTest do
  use Playbook.ConnCase

  alias Playbook.CampaignMembership
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, campaign_membership_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    campaign_membership = Repo.insert! %CampaignMembership{}
    conn = get conn, campaign_membership_path(conn, :show, campaign_membership)
    assert json_response(conn, 200)["data"] == %{"id" => campaign_membership.id,
      "campaign_id" => campaign_membership.campaign_id,
      "playbook_id" => campaign_membership.playbook_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, campaign_membership_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, campaign_membership_path(conn, :create), campaign_membership: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CampaignMembership, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, campaign_membership_path(conn, :create), campaign_membership: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    campaign_membership = Repo.insert! %CampaignMembership{}
    conn = put conn, campaign_membership_path(conn, :update, campaign_membership), campaign_membership: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CampaignMembership, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    campaign_membership = Repo.insert! %CampaignMembership{}
    conn = put conn, campaign_membership_path(conn, :update, campaign_membership), campaign_membership: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    campaign_membership = Repo.insert! %CampaignMembership{}
    conn = delete conn, campaign_membership_path(conn, :delete, campaign_membership)
    assert response(conn, 204)
    refute Repo.get(CampaignMembership, campaign_membership.id)
  end
end
