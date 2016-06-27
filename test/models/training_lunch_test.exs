defmodule ElixirExample.TrainingLunchTest do
  use ElixirExample.ModelCase

  alias ElixirExample.TrainingLunch

  @valid_attrs %{attendee: "some content", date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, topic: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TrainingLunch.changeset(%TrainingLunch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TrainingLunch.changeset(%TrainingLunch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
