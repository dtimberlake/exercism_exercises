defmodule Binary do
  import :math, only: [pow: 2]

  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.split("", trim: true)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.reduce_while(0, fn {s, index}, acc ->
      case s do
        "0" -> { :cont, acc }
        "1" -> { :cont, acc + pow(2, index) }
        _   -> { :halt, 0 }
      end
    end)
  end
end
