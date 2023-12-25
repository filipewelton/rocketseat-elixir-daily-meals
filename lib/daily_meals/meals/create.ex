defmodule DailyMeals.Meals.Create do
  alias Ecto.Repo
  alias DailyMeals.{Meal, Repo}
  alias DailyMeals.Error
  alias Ecto.Changeset

  def call(params) do
    with {:ok, changeset} <- changeset(params) do
      insert(changeset)
    end
  end

  defp changeset(params) do
    case Meal.changeset(params) do
      %Changeset{valid?: true} = changeset -> {:ok, changeset}
      %Changeset{valid?: false} = changeset -> Error.build(400, changeset)
      error -> error
    end
  end

  defp insert(changeset) do
    case Repo.insert(changeset) do
      {:ok, _} = returns -> returns
      {:error, error} -> Error.build(500, error)
    end
  end
end
