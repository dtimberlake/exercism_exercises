defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b, do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) do
    cond do
      is_sublist(a, b) -> :sublist
      is_sublist(b, a) -> :superlist
      true             -> :unequal
    end
  end

  def is_sublist(_, []), do: false
  def is_sublist(a, b) when hd(a) === hd(b) do
    if Enum.take(b, length(a)) == a do
      true
    else
      is_sublist(a, tl(b))
    end
  end
  def is_sublist(a, b) when hd(a) !== hd(b), do: is_sublist(a, tl(b))
end
