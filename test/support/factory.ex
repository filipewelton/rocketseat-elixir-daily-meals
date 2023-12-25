defmodule DailyMeals.Factory do
  use ExMachina.Ecto, repo: DailyMeals.Repo

  def meal_factory do
    kcal = :rand.uniform(1000)
    days = :rand.uniform(10)

    descricao =
      Faker.Lorem.words(10..20)
      |> Enum.join(" ")

    %{
      descricao: descricao,
      data: Faker.Date.backward(days),
      calorias: "#{kcal} kcal"
    }
  end

  def user_factory do
    %{
      nome: Faker.Person.name(),
      cpf: "111.444.777-35",
      email: Faker.Internet.email()
    }
  end
end
