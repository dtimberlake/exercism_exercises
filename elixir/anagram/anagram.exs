defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_char_totals = get_char_totals(base)
    candidates
    |> Enum.filter(&(String.downcase(&1) != String.downcase(base)))
    |> Enum.filter(&(String.length(&1) == String.length(base)))
    |> Enum.map(&get_char_totals(&1))
    |> Enum.filter(&candidates_filter(&1, base_char_totals))
    |> Enum.map(&Map.get(&1, :string))
  end

  def get_char_totals(string) do
    char_totals = string
    |> String.downcase
    |> String.to_char_list
    |> Enum.reduce([], &Keyword.update(&2, List.to_atom([&1]), 1, fn(x) -> x + 1 end))

    %{string: string, totals: char_totals}
  end

  def candidates_filter(%{totals: candidate_char_totals}, %{totals: base_char_totals}) do
    candidate_char_totals
    |> Enum.all?(fn({key, value}) ->
        Keyword.get(base_char_totals, key, 0) == value
      end)
  end
end
