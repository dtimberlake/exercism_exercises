defmodule ETL do
  @spec transform(map) :: map
  def transform(input) do
    input |> Enum.reduce(%{}, fn ({k, v}, acc) ->
      Enum.reduce(v, acc, fn (x, acc) ->
        Map.put(acc, String.downcase(x), k)
      end)
    end)
  end
end
