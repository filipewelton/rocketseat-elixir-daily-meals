defmodule DailyMealsWeb.ErrorJSON do
  alias Ecto.Changeset
  import Ecto.Changeset, only: [traverse_errors: 2]

  def render("error.json", %{reason: %Changeset{} = changeset}) do
    %{"errors" => parse_errors(changeset)}
  end

  def render("error.json", %{reason: reason}) do
    %{reason: reason}
  end

  defp parse_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
