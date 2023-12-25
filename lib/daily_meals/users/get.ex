defmodule DailyMeals.Users.Get do
  alias DailyMeals.Error
  alias DailyMeals.Repo
  alias DailyMeals.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> Error.build(404, %{user: "not found"})
      user -> {:ok, user}
    end
  end
end
