defmodule DailyMeals.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :descricao, :string
      add :data, :date
      add :calorias, :string
      add :user_id, references(:users, type: :binary_id)
    end
  end
end
