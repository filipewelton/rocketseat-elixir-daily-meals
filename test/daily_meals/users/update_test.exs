defmodule DailyMeals.Users.UpdateTest do
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.{Error, User}
  alias DailyMeals.Users.{Create, Update}

  setup do
    {:ok, user} = Create.call(build(:user))
    %{user: user}
  end

  describe "call/1" do
    test "when a valid id is given, returns the meal", %{user: user} do
      params = %{
        "email" => Faker.Internet.email(),
        "id" => user.id
      }

      response = Update.call(params)

      assert {:ok, %User{}} = response
    end

    test "when an invalid id is given, returns an error" do
      params = %{
        "email" => Faker.Internet.email(),
        "id" => Faker.UUID.v4()
      }

      response = Update.call(params)

      assert %Error{status: 404, result: %{user: "not found"}} = response
    end
  end
end
