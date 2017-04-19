defmodule Categorizer.Seed do
  use Categorizer.Repo

  def call do
    Repo.transaction fn ->
      categories = [
        %Category{id: 1, name: "Apps + Software"},
        %Category{id: 2, name: "Design", ancestry: {1}},
        %Category{id: 3, name: "3D & Animation", ancestry: {1, 2}},
        %Category{id: 4, name: "Arts & Photography", ancestry: {1, 2}},
        %Category{id: 5, name: "Developer Tools", ancestry: {1}},
        %Category{id: 6, name: "Games", ancestry: {1, 5}},
        %Category{id: 7, name: "Finance", ancestry: {1}},
        %Category{id: 8, name: "Personal Finance", ancestry: {1, 7}},
        %Category{id: 9, name: "Design"},
        %Category{id: 10, name: "Graphics", ancestry: {9}},
        %Category{id: 11, name: "3D", ancestry: {9, 10}},
        %Category{id: 12, name: "Gear + Gadgets"},
        %Category{id: 13, name: "Computers & Tablets", ancestry: {12}},
        %Category{id: 14, name: "Outdoors", ancestry: {12}},
        %Category{id: 15, name: "Online Courses"},
        %Category{id: 16, name: "Photography", ancestry: {15}},
        %Category{id: 17, name: "Mobile Photography", ancestry: {15, 16}},
        %Category{id: 18, name: "Self", ancestry: {15}},
        %Category{id: 19, name: "Food & Beverage", ancestry: {15, 18}},
        %Category{id: 20, name: "Stand", ancestry: {12, 13}},
        %Category{id: 21, name: "Lifestyle"},
        %Category{id: 22, name: "Health + Wellness", ancestry: {21}},
        %Category{id: 23, name: "IT & Security", ancestry: {15}},
        %Category{id: 24, name: "Software", ancestry: {15, 23}},
        %Category{id: 25, name: "Productivity", ancestry: {15}},
        %Category{id: 26, name: "Graphics", ancestry: {1, 9}},
        %Category{id: 27, name: "Themes + Templates", ancestry: {1, 9}},
        %Category{id: 28, name: "Television + Home Theather", ancestry: {12}},
        %Category{id: 29, name: "Television", ancestry: {12, 28}}
      ]

      for category <- categories, do: category |> Category.write!
    end
  end
end
