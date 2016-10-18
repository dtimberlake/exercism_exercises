defmodule Frequency do
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts |> prepare_text |> get_frequencies(workers)
  end

  defp prepare_text(texts) do
    texts
    |> Enum.map(&String.replace(&1, ~r/[.,\/#!$%\^&\*;:{}=\-_`~()\s\d]/, ""))
    |> Enum.map(&String.downcase(&1))
    |> Enum.flat_map(&String.split(&1, "", trim: true))
  end

  defp get_frequencies([], _), do: %{}
  defp get_frequencies(text, workers) do
    {:ok, sup} = Task.Supervisor.start_link()
    text
    |> chunk_evenly(workers)
    |> Enum.map(&Task.Supervisor.async(sup, __MODULE__, :worker, [&1]))
    |> Enum.map(&Task.await(&1))
    |> Enum.reduce(%{}, fn (m, acc) -> Map.merge(acc, m, fn (_, x, y) -> x + y end) end)
  end

  def worker(text) do
    Enum.reduce(text, %{}, fn (x, acc) -> Map.update(acc, x, 1, fn (y) -> y + 1 end) end)
  end

  defp chunk_evenly([_]=list, _), do: [list]
  defp chunk_evenly(list, workers) do
    size = round(Float.ceil(length(list) / workers))
    chunks = Enum.chunk(list, size, size, [])
    if length(chunks) <= workers do
      chunks
    else
      {list1, list2} = Enum.split(chunks, -1)
      zip_extra(list1, list2)
    end
  end

  defp zip_extra(list1, []), do: list1
  defp zip_extra([h1 | t1], [h2 | t2]), do: [h1 ++ [h2], zip_extra(t1, t2)]
end
