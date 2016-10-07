defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @dna_to_rna %{
      'G' => 'C',
      'C' => 'G',
      'T' => 'A',
      'A' => 'U'
    }

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    List.flatten Enum.map(dna, &Map.get(@dna_to_rna, [&1]))
  end
end
