defmodule Categorizer.Category.TaxonomyCreator do
  use Categorizer.Repo

  def call([name|rest]) do
    Repo.transaction fn ->
      category = %Category{name: name} |> Repo.insert

      call(rest, [category])
    end
  end

  def call([name|rest], parents) do
    ancestry = parents |> Enum.map(&(&1.id)) |> List.to_tuple
    category = %Category{name: name, ancestry: ancestry} |> Repo.insert

    call(rest, parents ++ [category])
  end

  def call([], parents) do
    parents |> List.last
  end
end
