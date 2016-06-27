defmodule ElixirExample.TrainingLunchControllerTest do
  use ElixirExample.ConnCase

  alias ElixirExample.TrainingLunch
  @valid_attrs %{attendee: "some content", date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, topic: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, training_lunch_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing training lunches"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, training_lunch_path(conn, :new)
    assert html_response(conn, 200) =~ "New training lunch"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, training_lunch_path(conn, :create), training_lunch: @valid_attrs
    assert redirected_to(conn) == training_lunch_path(conn, :index)
    assert Repo.get_by(TrainingLunch, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, training_lunch_path(conn, :create), training_lunch: @invalid_attrs
    assert html_response(conn, 200) =~ "New training lunch"
  end

  test "shows chosen resource", %{conn: conn} do
    training_lunch = Repo.insert! %TrainingLunch{}
    conn = get conn, training_lunch_path(conn, :show, training_lunch)
    assert html_response(conn, 200) =~ "Show training lunch"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, training_lunch_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    training_lunch = Repo.insert! %TrainingLunch{}
    conn = get conn, training_lunch_path(conn, :edit, training_lunch)
    assert html_response(conn, 200) =~ "Edit training lunch"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    training_lunch = Repo.insert! %TrainingLunch{}
    conn = put conn, training_lunch_path(conn, :update, training_lunch), training_lunch: @valid_attrs
    assert redirected_to(conn) == training_lunch_path(conn, :show, training_lunch)
    assert Repo.get_by(TrainingLunch, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    training_lunch = Repo.insert! %TrainingLunch{}
    conn = put conn, training_lunch_path(conn, :update, training_lunch), training_lunch: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit training lunch"
  end

  test "deletes chosen resource", %{conn: conn} do
    training_lunch = Repo.insert! %TrainingLunch{}
    conn = delete conn, training_lunch_path(conn, :delete, training_lunch)
    assert redirected_to(conn) == training_lunch_path(conn, :index)
    refute Repo.get(TrainingLunch, training_lunch.id)
  end
end
