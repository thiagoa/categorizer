ExUnit.start()

defmodule DatabaseCase do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      use Categorizer.Database
      alias Categorizer.Repo

      setup_all do
        Amnesia.Schema.create
        Amnesia.start

        on_exit fn ->
          Amnesia.stop
          Amnesia.Schema.destroy
        end

        :ok
      end

      setup do
        Categorizer.Database.create!

        on_exit fn ->
          Categorizer.Database.destroy
        end

        :ok
      end
    end
  end
end

