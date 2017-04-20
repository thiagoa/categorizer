defmodule Categorizer.Category.TaxonomyTreeCreatorTest do
  use DatabaseCase

  alias Categorizer.Category.{TaxonomyTreeCreator, Attributes}

  def find_category(leaf_name) do
    Category.where(name == leaf_name)
    |> Amnesia.Selection.values
    |> List.first
  end

  def full_name(leaf_name) do
    leaf_name |> find_category |> Attributes.full_name
  end

  test "creates a taxonomy tree" do
    TaxonomyTreeCreator.call(
      {
        "Fruits", [
          "Berry",
          { "Citrus", ["Orange", "Lemon"] },
          { "Exotic", ["Rambutan", "Lychee"] }
        ]
      }
    )

    Repo.transaction fn ->
      assert (Category |> Repo.all |> Enum.count) == 8

      assert full_name("Berry") == "Fruits / Berry"
      assert full_name("Orange") == "Fruits / Citrus / Orange"
      assert full_name("Lemon") == "Fruits / Citrus / Lemon"
      assert full_name("Rambutan") == "Fruits / Exotic / Rambutan"
      assert full_name("Lychee") == "Fruits / Exotic / Lychee"
    end
  end
end
