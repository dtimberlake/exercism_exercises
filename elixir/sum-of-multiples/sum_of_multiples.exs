defmodule SumOfMultiples do

  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.flat_map(&get_multiples(&1, limit))
    |> Enum.uniq
    |> Enum.sum
  end

  defp get_multiples(factor, limit) do
    0..div(limit - 1, factor)
    |> Enum.map(&(factor * &1))
  end
end
