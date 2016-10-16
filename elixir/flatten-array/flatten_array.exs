defmodule FlattenArray do
  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten(x), do: Enum.reverse(do_flatten(x, []))

  defp do_flatten([], acc), do: acc
  defp do_flatten([h | t], acc) when is_nil(h), do: do_flatten(t, acc)
  defp do_flatten([h | t], acc) when is_list(h), do: do_flatten(t, do_flatten(h, acc))
  defp do_flatten([h | t], acc), do: do_flatten(t, [h | acc])
end
