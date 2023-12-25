defmodule DailyMealsWeb.Router do
  use DailyMealsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DailyMealsWeb do
    pipe_through :api

    resources "/meals", MealsController, except: [:new, :edit]
    resources "/users", UsersController, except: [:new, :edit]
  end
end
