defmodule DailyMealsWeb.UsersJSON do
  def render("201.json", %{data: data}), do: data
  def render("200.json", %{data: data}), do: data
end
