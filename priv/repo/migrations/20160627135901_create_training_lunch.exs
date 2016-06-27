defmodule ElixirExample.Repo.Migrations.CreateTrainingLunch do
  use Ecto.Migration

  def change do
    create table(:training_lunches) do
      add :attendee, :string
      add :date, :datetime
      add :topic, :string

      timestamps()
    end

  end
end
