defmodule Categorizer.Category.AttributesTest do
  use DatabaseCase

  alias Categorizer.Category.{Attributes,TaxonomyCreator}

  test "gets the full name when having no ancestors" do
    leaf = TaxonomyCreator.call(["Apps + Software"])

    assert (leaf |> Attributes.full_name) == "Apps + Software"
  end

  test "gets the full name when having one ancestor" do
    leaf = TaxonomyCreator.call(["Lifestyle / Health + Wellness"])

    assert (leaf |> Attributes.full_name) == "Lifestyle / Health + Wellness"
  end

  test "gets the full name when having two ancestors" do
    leaf = TaxonomyCreator.call(~w(One Two Three))

    assert (leaf |> Attributes.full_name) == "One / Two / Three"
  end
end
