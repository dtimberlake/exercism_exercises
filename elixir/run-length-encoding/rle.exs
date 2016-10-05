defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    Regex.scan(~r/([a-zA-Z])\1*/, string, [capture: :first])
    |> List.flatten
    |> Enum.map(&String.split(&1, ""))
    |> Enum.map(fn(x) ->
        "#{length(x) - 1}#{List.first x}"
      end)
    |> Enum.join
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    Regex.scan(~r/([1-9]*)([a-zA-Z])/, string, [capture: :all_but_first])
    |> Enum.map(fn([n_str, str]) ->
        String.duplicate(str, String.to_integer n_str)
      end)
    |> Enum.join
  end
end
