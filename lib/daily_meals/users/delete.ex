defmodule DailyMeals.Users.Delete do
  alias DailyMeals.Repo
  alias DailyMeals.Users.Get

  def call(id) do
    with {:ok, user} <- Get.call(id) do
      delete(user)
    end
  end

  defp delete(user) do
    case Repo.delete(user) do
      {:ok, _} -> :ok
      {:error, _} -> raise(~c"User not found")
    end
  end
end
