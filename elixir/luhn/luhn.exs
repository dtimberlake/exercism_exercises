defmodule Luhn do
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce(0, fn ({n, i}, acc) ->
      if rem(i, 2) == 0 do
        acc + n
      else
        doubled = n * 2
        if doubled > 9 do
          acc + (doubled - 9)
        else
          acc + doubled
        end
      end
    end)
  end

  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    checksum_rem(number) == 0
  end

  @spec create(String.t()) :: String.t()
  def create(number) do
    case checksum_rem(number <> "0") do
      0 -> number <> "0"
      n ->   number <> Integer.to_string(10 - n)
    end
  end

  defp checksum_rem(number) do
    checksum(number) |> rem(10)
  end
end
