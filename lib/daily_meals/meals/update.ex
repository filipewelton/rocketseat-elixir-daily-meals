defmodule DailyMeals.Meals.Update do
  alias Ecto.Changeset
  alias DailyMeals.{Repo, Meal}
  alias DailyMeals.Meals.Get
  alias DailyMeals.Error

  def call(params) do
    with {:ok, struct} <- get_id(params),
         {:ok, changeset} <- changeset(struct, params) do
      update(changeset)
    end
  end

  defp get_id(%{"id" => id}) when is_bitstring(id) do
    case Get.call(id) do
      {:ok, _} = return -> return
      error -> error
    end
  end

  defp changeset(struct, params) do
    case Meal.changeset(struct, params) do
      %Changeset{valid?: true} = changeset -> {:ok, changeset}
      %Changeset{valid?: false} = changeset -> Error.build(400, changeset)
      error -> error
    end
  end

  defp update(changeset) do
    case Repo.update(changeset) do
      {:ok, _} = return -> return
      {:error, reason} -> Error.build(500, reason)
    end
  end
end
