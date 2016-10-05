defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split
    |> Enum.map(fn(x) ->
      Enum.join([
        String.first(x),
        Regex.replace(~r/[a-z\d\s.,\/#!$%\^&\*;:{}=\-_`~()]/, String.slice(x, 1..-1), "")
      ])
    end)
    |> Enum.join("")
    |> String.upcase
  end
end
