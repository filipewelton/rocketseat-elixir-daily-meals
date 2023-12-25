defmodule DailyMealsWeb.MealsJSON do
  def render("200.json", %{data: data}), do: data

  def render("201.json", %{data: data}), do: data
end
