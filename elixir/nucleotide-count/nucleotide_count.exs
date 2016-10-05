defmodule NucleotideCount do
  import List, only: [foldr: 3]
  import Map

  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    foldr(strand, 0, fn(x, acc) ->
      if x == nucleotide do
        acc + 1
      else
        acc
      end
    end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    acc = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    foldr(strand, acc, fn(x, acc) ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
  end
end
