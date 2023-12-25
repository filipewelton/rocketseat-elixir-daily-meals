defmodule DailyMeals.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DailyMealsWeb.Telemetry,
      DailyMeals.Repo,
      {DNSCluster, query: Application.get_env(:daily_meals, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DailyMeals.PubSub},
      DailyMealsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: DailyMeals.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    DailyMealsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
