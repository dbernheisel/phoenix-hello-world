# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirExample.Repo.insert!(%ElixirExample.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ElixirExample.Repo

Repo.insert! %ElixirExample.TrainingLunch{
  presenter: "David Bernheisel",
  topic: "Elixir/Phoenix",
  date: %Ecto.DateTime{
    year: 2016,
    month: 6,
    day: 26,
    hour: 12,
    min: 30,
    sec: 0}
}
