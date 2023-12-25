defmodule DailyMeals.Users.DeleteTest do
  alias DailyMeals.Error
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.Users.{Create, Delete}

  setup do
    {:ok, user} = Create.call(build(:user))

    %{user: user}
  end

  describe "call/1" do
    test "when a valid id is given, returns the meal", %{user: user} do
      response = Delete.call(user.id)
      assert :ok = response
    end

    test "when there are invalid params, returns an error" do
      id = Faker.UUID.v4()
      response = Delete.call(id)

      assert %Error{status: 404, result: %{user: "not found"}} = response
    end
  end
end
