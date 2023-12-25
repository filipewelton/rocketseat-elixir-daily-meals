defmodule DailyMealsWeb.MealsController do
  use DailyMealsWeb, :controller

  import DailyMeals

  alias DailyMealsWeb.FallBackController

  action_fallback FallBackController

  def create(connection, params) do
    with {:ok, data} <- create_meal(params) do
      connection
      |> put_status(201)
      |> render("201.json", data: data)
    end
  end

  def show(connection, params) do
    %{"id" => id} = params

    with {:ok, data} <- get_meal(id) do
      connection
      |> put_status(200)
      |> render("200.json", data: data)
    end
  end

  def update(connection, params) do
    with {:ok, data} <- update_meal(params) do
      connection
      |> put_status(200)
      |> render("200.json", data: data)
    end
  end

  def delete(conn, params) do
    %{"id" => id} = params

    with {:ok, _msg} <- delete_meal(id) do
      conn
      |> put_status(204)
      |> text("")
    end
  end
end
