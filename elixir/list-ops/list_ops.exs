defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn(_, acc) -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse([], l), do: l
  def reverse([h | t], l), do: reverse(t, [h | l])
  def reverse([]), do: []
  def reverse([_] = l), do: l
  def reverse([a, b]), do: [b, a]
  def reverse([a, b | t]), do: reverse(t, [b, a])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h | t], f), do: [f.(h) | map(t, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([ h | t], f), do: if f.(h), do: [h | filter(t, f)], else: filter(t, f)

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([ h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([h | tail], b), do: [h | append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat(x), do: reverse(do_concat(x, []))

  def do_concat([], acc), do: acc
  def do_concat([h | t], acc) when is_list(h), do: do_concat(t, do_concat(h, acc))
  def do_concat([h | t], acc), do: do_concat(t, [h | acc])
end
