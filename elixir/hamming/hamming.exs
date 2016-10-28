defmodule Hamming do
  @spec hamming_distance([char], [char]) :: {atom, non_neg_integer}
  def hamming_distance(stream1, stream2) do
    if length(stream1) != length(stream2) do
      { :error, "Lists must be the same length" }
    else
      { :ok, diff(stream1, stream2) }
    end
  end
  
  defp diff(stream1, stream2) do
    Enum.zip(stream1, stream2)
    |> Enum.count(fn {x, y} -> x != y end)
  end
end
