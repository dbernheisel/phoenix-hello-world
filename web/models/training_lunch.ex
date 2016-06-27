defmodule ElixirExample.TrainingLunch do
  use ElixirExample.Web, :model

  schema "training_lunches" do
    field :presenter, :string
    field :date, Ecto.DateTime
    field :topic, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:presenter, :date, :topic])
    |> validate_required([:presenter, :date, :topic])
  end
end
