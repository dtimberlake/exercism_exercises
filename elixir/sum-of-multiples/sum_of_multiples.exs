defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Enum.reduce(factors, MapSet.new([]), &get_multiples(limit, &1, 1, &2))
    |> Enum.sum
  end

  def get_multiples(limit, factor, n, mapset) do
    value = factor * n
    if value >= limit do
      mapset
    else
      get_multiples(limit, factor, n + 1, MapSet.put(mapset, value))
    end
  end
end
