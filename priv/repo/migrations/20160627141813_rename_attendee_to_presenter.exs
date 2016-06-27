defmodule ElixirExample.Repo.Migrations.RenameAttendeeToPresenter do
  use Ecto.Migration

  def change do
    rename table(:training_lunches), :attendee, to: :presenter
  end
end
