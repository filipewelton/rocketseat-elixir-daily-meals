defmodule DailyMealsWeb.UsersControllerTest do
  use DailyMealsWeb.ConnCase, async: true

  import DailyMeals.Factory

  alias DailyMeals.User
  alias DailyMeals.Users.Create

  describe "create" do
    test "when all params are valid, creates a user", %{conn: conn} do
      params = build(:user)

      conn
      |> post("/api/users", params)
      |> json_response(201)
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = build(:user, email: 1234)

      conn
      |> post("/api/users", params)
      |> json_response(400)
    end
  end

  describe "get" do
    test "when id exist, return the user", %{conn: conn} do
      user = build(:user)
      {:ok, %User{id: id}} = Create.call(user)

      conn
      |> get("/api/users/#{id}")
      |> json_response(200)
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = Faker.UUID.v4()

      conn
      |> get("/api/users/#{id}")
      |> json_response(404)
    end
  end

  describe "update" do
    test "when id exist, update the users", %{conn: conn} do
      {:ok, user} =
        build(:user)
        |> Create.call()

      id = user.id

      params = %{
        calorias: "1.257 kcal"
      }

      conn
      |> patch("/api/users/#{id}", params)
      |> json_response(200)
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = Faker.UUID.v4()
      params = %{email: Faker.Internet.email()}

      conn
      |> patch("/api/users/#{id}", params)
      |> json_response(404)
    end
  end

  describe "delete" do
    test "when id exist, delete the users", %{conn: conn} do
      user = build(:user)
      {:ok, %User{id: id}} = Create.call(user)

      conn
      |> delete("/api/users/#{id}")
      |> response(204)
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = Faker.UUID.v4()

      conn
      |> delete("/api/users/#{id}")
      |> json_response(404)
    end
  end
end
