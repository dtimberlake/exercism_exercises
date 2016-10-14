defmodule Roman do
  @roman_numerals [ ["I", "V"], ["X", "L"], ["C", "D"], ["M"] ]

  @spec numerals(pos_integer) :: String.t
  def numerals(n) do
    n
    |> Integer.digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce([], &do_numerals(&1, &2))
    |> Enum.reverse
    |> List.to_string
  end

  defp do_numerals({n, i}, acc) when n == 4, do: acc ++ [[get_numeral(i, 0), get_numeral(i, 1)]]
  defp do_numerals({n, i}, acc) when n == 9, do: acc ++ [[get_numeral(i, 0), get_numeral(i + 1, 0)]]
  defp do_numerals({n, i}, acc) when n == 5, do: acc ++ [[get_numeral(i, 1)]]
  defp do_numerals({n, i}, acc) when n < 4, do: acc ++ [List.duplicate(get_numeral(i, 0), n)]
  defp do_numerals({n, i}, acc), do: acc ++ [[get_numeral(i, 1), List.duplicate(get_numeral(i, 0), n - 5)]]
  end

  defp get_numeral(i, j), do: Enum.at(@roman_numerals, i) |> Enum.at(j)
end
