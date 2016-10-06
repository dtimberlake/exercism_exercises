defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @brackets %{
      ?{ => ?},
      ?( => ?),
      ?[ => ?]
    }

  @spec check_brackets(String.t) :: boolean
  def check_brackets(""), do: true
  def check_brackets(str) do
    String.replace(str, ~r/[^{}[\]\(\)]*/, "")
    |> String.to_charlist
    |> do_check_brackets([])
  end

  defp do_check_brackets([], []), do: true
  defp do_check_brackets([], [_|_]), do: false
  defp do_check_brackets([h | t], closing_brackets) do
    if Map.has_key?(@brackets, h) do
      do_check_brackets(t, [@brackets[h]] ++ closing_brackets )
    else
      if h == List.first(closing_brackets) do
        do_check_brackets(t, tl(closing_brackets))
      else
        false
      end
    end
  end
end
