defmodule DailyMeals.Meals.GetTest do
  use DailyMeals.DataCase, async: true

  import DailyMeals.Factory

  alias DailyMeals.Meal
  alias DailyMeals.Meals.{Create, Get}
  alias DailyMeals.Users.Create, as: CreateUser
  alias DailyMeals.Error

  setup do
    user = build(:user)

    {:ok, user} =
      CreateUser.call(user)

    %{user: user}
  end

  describe "call/1" do
    test "when a valid id is given, returns the meal", %{user: user} do
      meal = build(:meal, user: user)

      {:ok, %Meal{id: in_id}} = Create.call(meal)

      response = Get.call(in_id)

      assert {:ok, %Meal{}} = response
    end

    test "when an invalid id is given, returns an error" do
      response = Get.call(Faker.UUID.v4())

      assert %Error{status: 404, result: "Instance not found"} = response
    end
  end
end
