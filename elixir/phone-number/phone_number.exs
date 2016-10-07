defmodule Phone do
  import String, only: [slice: 2]
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    str = raw |> String.replace(~r/[^0-9a-zA-Z]/, "")
    do_number(str, String.length(str))
  end

  defp do_number(_, len) when len < 10 or len > 11, do: "0000000000"
  defp do_number(str, 10), do: str
  defp do_number(str, 11) do
    if (Regex.match?(~r/^[1].*/, str)), do: slice(str, 1..-1), else: "0000000000"
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw |> number |> slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    str = raw |> number
    "(#{slice(str, 0..2)}) #{slice(str, 3..5)}-#{slice(str, 6..9)}"
  end
end
