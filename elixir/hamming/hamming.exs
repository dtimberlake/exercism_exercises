defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {atom, non_neg_integer}
  def hamming_distance(strand1, strand2), do: do_hamming_distance(strand1, strand2, 0)

  defp do_hamming_distance(s1, s2, _) when length(s1) != length(s2), do: {:error, "Lists must be the same length"}
  defp do_hamming_distance([], [], acc), do: {:ok, acc}
  defp do_hamming_distance([h1 | t1], [h2 | t2], acc) do
    acc = if h1 != h2, do: acc + 1, else: acc
    do_hamming_distance(t1, t2, acc)
  end
end
