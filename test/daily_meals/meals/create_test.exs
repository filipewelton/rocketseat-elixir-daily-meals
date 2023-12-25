defmodule DailyMeals.Meals.CreateTest do
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.Meal
  alias DailyMeals.Meals.Create, as: CreateMeal
  alias DailyMeals.Users.Create, as: CreateUser
  alias DailyMeals.Error

  setup do
    user = build(:user)
    {:ok, user} = CreateUser.call(user)

    %{user: user}
  end

  describe "call/1" do
    test "when all params are valid, returns the meal", %{user: user} do
      response =
        build(:meal, user: user)
        |> CreateMeal.call()

      assert {:ok, %Meal{}} = response
    end

    test "when there are invalid params, returns an error" do
      response =
        build(:meal, descricao: 1234)
        |> CreateMeal.call()

      assert %Error{status: 400, result: "user parameter is required"} = response
    end
  end
end
