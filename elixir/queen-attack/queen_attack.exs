defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ { 0, 3 }, black \\ { 7, 3 })
  def new(queen, queen), do: raise ArgumentError
  def new(white, black), do: %Queens{white: white, black: black}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for y <-- 0..7, x <-- 0..7 do
      cond do
        queens.white == { y, x } -> "W"
        queens.black == { y, x } -> "B"
        true                     -> "_"
      end
    end
    |> Enum.chunk(8)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{black: { by, bx}, white: { wy, wx }}) do
    cond do
      by == wy                     -> true
      bx == wx                     -> true
      abs(by - wy) == abs(bx - wx) -> true
      :otherwise                   -> false
    end
  end
end
