defmodule DailyMeals.Users.Update do
  alias DailyMeals.Repo
  alias DailyMeals.User
  alias DailyMeals.Users.Get
  alias Ecto.Changeset
  alias DailyMeals.Error

  def call(params) do
    with {:ok, struct} <- get_user(params),
         {:ok, changeset} <- changeset(struct, params) do
      update(changeset)
    end
  end

  defp get_user(%{"id" => id}) do
    case Get.call(id) do
      {:ok, _} = return -> return
      error -> error
    end
  end

  defp changeset(struct, params) do
    case User.changeset(struct, params) do
      %Changeset{valid?: true} = changeset -> {:ok, changeset}
      changeset -> Error.build(400, changeset)
    end
  end

  defp update(changeset) do
    case Repo.update(changeset) do
      {:ok, _} = return -> return
      {:error, error} -> Error.build(500, error)
    end
  end
end
