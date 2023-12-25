defmodule DailyMeals do
  alias DailyMeals.{Meals, Users}
  alias Meals.Create, as: CreateMeal
  alias Meals.Delete, as: DeleteMeal
  alias Meals.Get, as: GetMeal
  alias Meals.Update, as: UpdateMeal
  alias Users.Create, as: CreateUser
  alias Users.Delete, as: DeleteUser
  alias Users.Get, as: GetUser
  alias Users.Update, as: UpdateUser

  defdelegate create_meal(params), to: CreateMeal, as: :call

  defdelegate get_meal(id), to: GetMeal, as: :call

  defdelegate update_meal(params), to: UpdateMeal, as: :call

  defdelegate delete_meal(id), to: DeleteMeal, as: :call

  defdelegate create_user(params), to: CreateUser, as: :call

  defdelegate delete_user(params), to: DeleteUser, as: :call

  defdelegate get_user(params), to: GetUser, as: :call

  defdelegate update_user(params), to: UpdateUser, as: :call
end
