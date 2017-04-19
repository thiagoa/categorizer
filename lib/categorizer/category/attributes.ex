defmodule Categorizer.Category.Attributes do
  use Categorizer.Repo

  def full_name(category) when is_map(category) do
    Repo.transaction fn ->
      category |> extract_path |> Enum.join(" / ")
    end
  end

  defp extract_path(%Category{name: name, ancestry: nil}), do: [name]
  defp extract_path(%Category{name: name, ancestry: ancestry}) do
    path = ancestry
    |> Tuple.to_list
    |> Enum.map(&Repo.get(Category, &1).name)

    path ++ [name]
  end
end
