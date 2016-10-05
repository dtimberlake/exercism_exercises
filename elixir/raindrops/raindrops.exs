defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @type state :: { pos_integer, String.t }

  @spec convert(pos_integer) :: String.t
  def convert(number) do
    {number, ""}
    |> add_on_no_rem(3, "Pling")
    |> add_on_no_rem(5, "Plang")
    |> add_on_no_rem(7, "Plong")
    |> do_convert
  end

  @spec add_on_no_rem(state, pos_integer, String.t) :: {pos_integer, String.t}
  defp add_on_no_rem({num, acc}, div, str) when rem(num, div) == 0, do: {num, acc <> str}
  defp add_on_no_rem({num, acc}, _, _), do: {num, acc}

  @spec do_convert(state) :: String.t
  defp do_convert({number, ""}), do: Integer.to_string(number)
  defp do_convert({number, string}), do: string
end
