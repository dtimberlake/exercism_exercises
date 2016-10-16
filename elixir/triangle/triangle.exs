defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c), do: [a, b, c] |> Enum.sort |> do_kind

  defp do_kind([h | _]) when h <= 0, do: { :error, "all side lengths must be positive" }
  defp do_kind([a, b, c]) when a + b <= c, do: { :error, "side lengths violate triangle inequality" }
  defp do_kind(l) do
    set = MapSet.new l
    case MapSet.size(set) do
      1 -> { :ok, :equilateral }
      2 -> { :ok, :isosceles }
      3 -> { :ok, :scalene }
    end
  end
end
