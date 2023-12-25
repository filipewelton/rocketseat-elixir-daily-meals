defmodule DailyMeals.Meals.DeleteTest do
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.Meal
  alias DailyMeals.Meals.{Create, Delete}
  alias DailyMeals.Users.Create, as: CreateUser

  setup do
    user = build(:user)

    {:ok, user} =
      CreateUser.call(user)

    %{user: user}
  end

  describe "call/1" do
    test "when a valid id is given, returns a deleted user", %{user: user} do
      meals = build(:meal, user: user)

      {:ok, %Meal{id: id}} = Create.call(meals)

      response = Delete.call(id)
      expected_response = {:ok, "Instance delete successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      assert_raise(Ecto.Query.CastError, fn ->
        Delete.call(0)
      end)
    end
  end
end
