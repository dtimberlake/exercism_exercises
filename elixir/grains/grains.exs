defmodule Grains do
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    {square, _} = do_grains_square(number)
    square
  end

  @spec total :: pos_integer
  def total do
    {_, total} = do_grains_square(64)
    total
  end

  defp do_grains_square(1), do: {1, 1}
  defp do_grains_square(n) do
    2..n |> Enum.reduce({1, 1}, fn (n, {grains, sum}) ->
      next_grains = grains * 2
      {next_grains, sum + next_grains}
    end)
  end
end
