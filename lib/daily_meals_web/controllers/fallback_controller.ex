defmodule DailyMealsWeb.FallBackController do
  use DailyMealsWeb, :controller

  alias DailyMealsWeb.ErrorJSON
  alias DailyMeals.Error

  def call(connection, %Error{status: status, result: result}) do
    connection
    |> put_status(status)
    |> put_view(ErrorJSON)
    |> render("error.json", reason: result)
  end
end
