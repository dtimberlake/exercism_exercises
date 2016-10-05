defmodule Bob do
  import String
  import Regex

  def hey(input) do
    cond do
      Regex.match?(~r/^[\s]*$/, input) ->
        "Fine. Be that way!"
      Regex.match?(~r/\?$/, input) ->
        "Sure."
      (not Regex.match?(~r/[a-z]/, input)) and (
        (Regex.match?(~r/[A-Z]/, input)) or
          Regex.match?(~r/[^a-zA-Z\d\s.,\/#!$%\^&\*;:{}=\-_`~()]/, input)
      ) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end
end
