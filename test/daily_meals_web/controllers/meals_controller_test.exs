defmodule DailyMealsWeb.MealsControllerTest do
  use DailyMealsWeb.ConnCase, async: true

  import DailyMeals.Factory

  alias DailyMeals.Meal
  alias DailyMeals.Meals.Create
  alias DailyMeals.Users.Create, as: CreateUser

  setup do
    user = build(:user)
    {:ok, user} = CreateUser.call(user)
    %{user: user}
  end

  describe "create" do
    test "when all params are valid, creates a meal", %{conn: conn, user: user} do
      params = build(:meal, user: user)

      conn
      |> post("/api/meals", params)
      |> json_response(201)
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{descricao: "some text"}

      conn
      |> post("/api/meals", params)
      |> json_response(400)
    end
  end

  describe "get" do
    test "when id exist, return the meal", %{conn: conn, user: user} do
      meal = build(:meal, user: user)
      {:ok, %Meal{id: id}} = Create.call(meal)

      conn
      |> get("/api/meals/#{id}")
      |> json_response(200)
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = Faker.UUID.v4()

      conn
      |> get("/api/meals/#{id}")
      |> json_response(404)
    end
  end

  describe "update" do
    test "when id exist, update the meal", %{conn: conn, user: user} do
      meal = build(:meal, user: user)

      params = %{
        calorias: "1.257 kcal"
      }

      {:ok, %Meal{id: id}} = Create.call(meal)

      conn
      |> patch("/api/meals/#{id}", params)
      |> json_response(200)
    end

    test "when not exist id, return an error", %{conn: conn} do
      id = Faker.UUID.v4()
      params = %{calorias: "1.1257 kcal"}

      conn
      |> patch("/api/meals/#{id}", params)
      |> json_response(404)
    end
  end

  describe "delete" do
    test "when id exist, delete the meal", %{conn: conn, user: user} do
      meal = build(:meal, user: user)
      {:ok, %Meal{id: id}} = Create.call(meal)

      conn
      |> delete("/api/meals/#{id}")
      |> response(204)
    end

    test "when id not exist, return an error", %{conn: conn} do
      id = Faker.UUID.v4()

      conn
      |> delete("/api/meals/#{id}")
      |> json_response(404)
    end
  end
end
