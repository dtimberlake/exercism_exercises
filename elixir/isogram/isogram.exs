defmodule Isogram do
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence = sentence |> String.replace(~r/[\s-]/, "")
    sentence
    |> String.to_charlist
    |> MapSet.new
    |> MapSet.size
    |> is_equal(String.length(sentence))
  end

  defp is_equal(a, b), do: a == b
end
