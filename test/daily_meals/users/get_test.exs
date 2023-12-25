defmodule DailyMeals.Users.GetTest do
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.User
  alias DailyMeals.Users.{Create, Get}

  setup do
    {:ok, user} = Create.call(build(:user))

    %{user: user}
  end

  describe "call/1" do
    test "when a valid id is given, returns the user", %{user: user} do
      response = Get.call(user.id)
      assert {:ok, %User{}} = response
    end

    test "when an invalid id is given, returns an error" do
      id = 1234

      assert_raise(Ecto.Query.CastError, fn ->
        Get.call(id)
      end)
    end
  end
end
