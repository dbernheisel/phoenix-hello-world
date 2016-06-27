defmodule ElixirExample.TrainingLunchController do
  use ElixirExample.Web, :controller

  alias ElixirExample.TrainingLunch

  def index(conn, _params) do
    training_lunches = Repo.all(TrainingLunch)
    render(conn, "index.html", training_lunches: training_lunches)
  end

  def new(conn, _params) do
    changeset = TrainingLunch.changeset(%TrainingLunch{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"training_lunch" => training_lunch_params}) do
    changeset = TrainingLunch.changeset(%TrainingLunch{}, training_lunch_params)

    case Repo.insert(changeset) do
      {:ok, _training_lunch} ->
        conn
        |> put_flash(:info, "Training lunch created successfully.")
        |> redirect(to: training_lunch_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    training_lunch = Repo.get!(TrainingLunch, id)
    render(conn, "show.html", training_lunch: training_lunch)
  end

  def edit(conn, %{"id" => id}) do
    training_lunch = Repo.get!(TrainingLunch, id)
    changeset = TrainingLunch.changeset(training_lunch)
    render(conn, "edit.html", training_lunch: training_lunch, changeset: changeset)
  end

  def update(conn, %{"id" => id, "training_lunch" => training_lunch_params}) do
    training_lunch = Repo.get!(TrainingLunch, id)
    changeset = TrainingLunch.changeset(training_lunch, training_lunch_params)

    case Repo.update(changeset) do
      {:ok, training_lunch} ->
        conn
        |> put_flash(:info, "Training lunch updated successfully.")
        |> redirect(to: training_lunch_path(conn, :show, training_lunch))
      {:error, changeset} ->
        render(conn, "edit.html", training_lunch: training_lunch, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    training_lunch = Repo.get!(TrainingLunch, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(training_lunch)

    conn
    |> put_flash(:info, "Training lunch deleted successfully.")
    |> redirect(to: training_lunch_path(conn, :index))
  end
end
