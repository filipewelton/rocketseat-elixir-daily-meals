defmodule DailyMeals.Users.CreateTest do
  use DailyMeals.DataCase

  import DailyMeals.Factory

  alias DailyMeals.{User, Error}
  alias DailyMeals.Users.Create
  alias Ecto.Changeset

  describe "call/1" do
    test "when all params are valid, returns the user" do
      response = Create.call(build(:user))

      assert {:ok, %User{}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:user, cpf: "11144477735")
      response = Create.call(params)

      assert %Error{status: 400, result: %Changeset{valid?: false}} = response
    end
  end
end
