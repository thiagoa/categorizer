defmodule Categorizer.Category.TaxonomyTreeCreator do
  use Categorizer.Repo

  def call({root_name, subtrees}) do
    Repo.transaction fn ->
      root = create_category name: root_name, ancestry: nil
      create_subtrees subtrees, [root]
    end
  end

  defp create_subtrees([subtree|rest], parents) do
    create_one_subtree subtree, parents
    create_subtrees rest, parents
  end

  defp create_subtrees([], _), do: nil

  defp create_one_subtree({root_name, leafs}, parents) do
    root = create_category(root_name, parents)
    create_leafs leafs, parents ++ [root]
  end

  defp create_one_subtree(root_name, parents) do
    create_category root_name, parents
  end

  defp create_leafs([leaf_name|rest], parents) do
    create_category leaf_name, parents
    create_leafs rest, parents
  end

  defp create_leafs([], _), do: nil

  defp create_category(name, parents) do
    ancestry = parents |> Enum.map(&(&1.id)) |> List.to_tuple
    create_category name: name, ancestry: ancestry
  end
  
  defp create_category(name: name, ancestry: ancestry) do
    %Category{name: name, ancestry: ancestry} |> Repo.insert
  end
end
