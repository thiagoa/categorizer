defmodule Categorizer.Repo do
  require Amnesia.Helper
  use Categorizer.Database

  defmacro __using__(_opts) do
    quote do
      use Categorizer.Database
      alias Categorizer.Repo
    end
  end

  def transaction(callback) do
    Amnesia.transaction! do: callback.()
  end

  def all(module) do
    module.foldl [], &[&1|&2]
  end

  def get(module, id) do
    module.read(id)
  end

  def insert(%module{} = changeset) do
    changeset |> module.write
  end
end
