defmodule Change do
  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    values |> Enum.sort(&(&1 >= &2)) |> generate(amount, %{})
  end

  @spec generate(list, integer, map) :: {:ok, map} | :error
  defp generate([], 0, change), do: { :ok, change }

  defp generate([], _, _), do: :error

  defp generate([h | tail], amount, change) when div(amount, h) == 0 do
    generate(tail, amount, Map.put(change, h, 0))
  end

  defp generate([h | tail], amount, change) do
    Enum.reduce_while(div(amount, h)..0, 0, fn (n, _) ->
      case generate(tail, amount - (h * n), Map.put(change, h, n)) do
        { :ok, change } -> { :halt, { :ok, change }}
        :error -> { :cont, :error }
      end
    end)
  end
end
