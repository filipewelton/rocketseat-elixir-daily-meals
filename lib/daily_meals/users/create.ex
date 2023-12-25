defmodule DailyMeals.Users.Create do
  alias DailyMeals.Error
  alias DailyMeals.{User, Repo}
  alias Ecto.Changeset

  def call(params) do
    with {:ok, changeset} <- changeset(params) do
      insert(changeset)
    end
  end

  defp changeset(params) do
    case User.changeset(params) do
      %Changeset{valid?: true} = changeset -> {:ok, changeset}
      changeset -> Error.build(400, changeset)
    end
  end

  defp insert(changeset) do
    case Repo.insert(changeset) do
      {:ok, _} = returns -> returns
      {:error, reason} -> Error.build(500, reason)
    end
  end
end
