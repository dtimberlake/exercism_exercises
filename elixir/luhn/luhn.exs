defmodule Luhn do
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.reverse
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.with_index
    |> Enum.map(&do_checksum(&1))
    |> Enum.sum
  end

  defp do_checksum({n, i}) when rem(i, 2) == 0, do: n
  defp do_checksum({n, _}) when n > 5, do: (n * 2) - 9
  defp do_checksum({n, _}), do: n * 2

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
