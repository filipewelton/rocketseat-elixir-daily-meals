defmodule DailyMealsWeb.UsersController do
  use DailyMealsWeb, :controller

  import DailyMeals

  alias DailyMealsWeb.FallBackController

  action_fallback FallBackController

  def create(conn, params) do
    with {:ok, user} <- create_user(params) do
      conn
      |> put_status(201)
      |> render("201.json", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- get_user(id) do
      conn
      |> put_status(200)
      |> render("200.json", data: user)
    end
  end

  def update(conn, params) do
    with {:ok, user} <- update_user(params) do
      conn
      |> put_status(200)
      |> render("200.json", data: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with :ok <- delete_user(id) do
      conn
      |> put_status(204)
      |> text("")
    end
  end
end
