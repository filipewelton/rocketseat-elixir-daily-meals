defmodule DailyMeals.Meals.UpdateTest do
  use DailyMeals.DataCase, async: true

  import DailyMeals.Factory

  alias Ecto.Changeset
  alias DailyMeals.{Meal, Error}
  alias DailyMeals.Meals.Update
  alias DailyMeals.Users.Create, as: CreateUser

  setup do
    user = build(:user)

    {:ok, user} =
      CreateUser.call(user)

    %{user: user}
  end

  describe "call/2" do
    test "when a valid id is given, returns the meal", %{user: user} do
      meal = build(:meal, user: user)

      {:ok, %Meal{id: id}} =
        meal
        |> Meal.changeset()
        |> Repo.insert()

      params = %{
        "id" => id,
        "descricao" => "Pizza Quatro Queijos"
      }

      response = Update.call(params)

      assert {:ok, %Meal{descricao: "Pizza Quatro Queijos"}} = response
    end

    test "when an invalid id is given, returns an error", %{user: user} do
      meal = build(:meal, user: user)

      {:ok, %Meal{id: id}} =
        meal
        |> Meal.changeset()
        |> Repo.insert()

      params = %{
        "id" => id,
        "descricao" => "Pizza Quatro Queijos",
        "calorias" => 195
      }

      response = Update.call(params)

      assert %Error{status: 400, result: %Changeset{valid?: false}} = response
    end
  end
end
