defmodule DailyMeals.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias DailyMeals.Meal

  @primary_key {:id, :binary_id, autogenerate: true}
  @creation_fields [:nome, :cpf, :email]
  @update_fields @creation_fields -- [:cpf]
  @derive {Jason.Encoder, only: [:nome, :cpf, :email]}

  schema "users" do
    field :nome, :string
    field :cpf, :string
    field :email, :string
    has_many :meals, Meal
    timestamps()
  end

  def changeset(values) do
    handle_changeset(%__MODULE__{}, values, @creation_fields)
  end

  def changeset(struct, values) do
    handle_changeset(struct, values, @update_fields)
  end

  defp handle_changeset(struct, values, fields) do
    struct
    |> cast(values, fields)
    |> validate_required(fields)
    |> validate_length(:nome, min: 3)
    |> validate_format(:cpf, ~r/\d{3}.\d{3}.\d{3}-\d{2}/)
    |> validate_length(:email, max: 320)
    |> unique_constraint([:cpf])
    |> unique_constraint([:email])
  end
end
