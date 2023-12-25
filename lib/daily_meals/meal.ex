defmodule DailyMeals.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias DailyMeals.{User, Error}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @creation_fields [:descricao, :data, :calorias]
  @update_fields [:descricao, :calorias]
  @derive {Jason.Encoder, only: [:descricao, :data, :calorias]}

  schema "meals" do
    field :descricao, :string
    field :data, :date
    field :calorias, :string
    belongs_to :user, User
  end

  def changeset(values) do
    %__MODULE__{}
    |> cast(values, @creation_fields)
    |> validate_required(@creation_fields)
    |> put_user(values)
  end

  def changeset(struct, field_values) do
    struct
    |> cast(field_values, @update_fields)
    |> validate_required(@update_fields)
  end

  defp put_user(changeset, values) do
    user = Map.get(values, "user", Map.get(values, :user))

    if user == nil do
      Error.build(400, "user parameter is required")
    else
      put_assoc(changeset, :user, user)
    end
  end
end
