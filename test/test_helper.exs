ExUnit.start()

defmodule DatabaseCase do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case

      setup_all do
        Amnesia.Schema.create
        Amnesia.start
        Categorizer.Database.create!

        on_exit fn ->
          Categorizer.Database.destroy
          Amnesia.stop
          Amnesia.Schema.destroy
        end

        :ok
      end
    end
  end
end

