defmodule DailyMeals.MealTest do
  alias DailyMeals.Error
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias Ecto.Changeset
  alias DailyMeals.Meal
  alias DailyMeals.Users.Create

  setup do
    user = build(:user)

    {:ok, user} =
      Create.call(user)

    %{user: user}
  end

  describe "changeset/1" do
    test "when all params are valid", %{user: user} do
      params = %{
        descricao: "sometext",
        data: NaiveDateTime.utc_now(),
        calorias: "186 kcal",
        user: user
      }

      response = Meal.changeset(params)

      assert %Changeset{valid?: true} = response
    end

    test "when there params invalid" do
      params = %{
        descricao: "sometext",
        data: NaiveDateTime.utc_now(),
        calorias: 186
      }

      response = Meal.changeset(params)

      assert %Error{status: 400, result: "user parameter is required"} = response
    end
  end
end
