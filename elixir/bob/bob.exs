defmodule Bob do
  def hey(input) do
    cond do
      has_only_white_space(input) -> "Fine. Be that way!"
      is_question(input)          -> "Sure."
      is_yelling(input)           -> "Whoa, chill out!"
      :otherwise                  -> "Whatever."
    end
  end

  defp has_only_white_space(input), do: Regex.match?(~r/^[\s]*$/, input) 
  defp is_question(input), do: Regex.match?(~r/\?$/, input)  
  defp is_yelling(input) do
    (has_no_downcase(input) and has_upcase(input)) or only_non_english(input)
  end

  defp has_no_downcase(input), do: not Regex.match?(~r/[a-z]/, input)
  defp has_upcase(input), do: Regex.match?(~r/[A-Z]/, input)
  defp only_non_english(input) do
    len = Regex.replace(~r/[a-zA-Z\s\d.,\/#!$%\^&\*;:{}=\-_`~()?']/, input, "")
    |> String.length
    len > 0
  end
end

