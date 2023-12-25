defmodule DailyMeals.Meals.Delete do
  alias DailyMeals.{Repo, Meal}
  alias DailyMeals.Error

  def call(id) do
    case Repo.get(Meal, id) do
      nil ->
        Error.build(404, "Instance not found")

      meal ->
        Repo.delete(meal)
        {:ok, "Instance delete successfully"}
    end
  end
end
