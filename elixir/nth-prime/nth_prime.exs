defmodule Prime do
  defmodule Model do
    alias :math, as: Math
    defstruct target_n: 2, last_n: 1, last_prime: 2, num: 3, div: 3, divMax: 1

    def next_num(model) do
      %{ model |
        num: model.num + 2,
        divMax: Float.floor(Math.sqrt(model.num + 2)),
        div: 3
      }
    end
  end

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(n) when n <= 0, do: raise "n can not be <= 0"
  def nth(target_n) do
    do_nth(%Model{target_n: target_n})
  end

  defp do_nth(model) do
    cond do
      model.target_n == model.last_n -> model.last_prime
      model.div > model.divMax ->
        do_nth(%{ Model.next_num(model) | last_n: model.last_n + 1, last_prime: model.num})
      rem(model.num, model.div) == 0 ->
        do_nth(Model.next_num(model))
      true ->
        do_nth(%{ model | div: model.div + 2})
    end
  end
end
