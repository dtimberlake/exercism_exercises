defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ { 0, 3 }, black \\ { 7, 3 })

  def new(white, black) when white == black, do: raise ArgumentError

  def new(white, black), do: %__MODULE__{white: white, black: black}

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board
    |> replace_queen(queens.black, "B")
    |> replace_queen(queens.white, "W")
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  def board(), do: List.duplicate("_", 8) |> List.duplicate(8) 

  def replace_queen(board, { y, x }, identifier) do
    row = Enum.at(board, y) |> List.replace_at(x, identifier)
    board |> List.replace_at(y, row)
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
