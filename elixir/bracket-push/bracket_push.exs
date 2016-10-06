defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(""), do: true
  def check_brackets(str) do
    Regex.replace(~r/[^{}[\]\(\)]*/, str, "")
    |> String.split("", trim: true)
    |> do_check_brackets
  end

  @doc """
  do_check_brackets finds the next closing bracket and sends it and the sublist
  to check_sublist.
  """
  def do_check_brackets([]), do: true
  def do_check_brackets([_]), do: false
  def do_check_brackets([h | t]) do
    case get_closing_bracket(h) do
      :error -> false
      {:ok, closing_bracket} ->
        case check_sublist(closing_bracket, t) do
          {:ok, t}    -> do_check_brackets(t)
          :error      -> false
        end
    end
  end

  def check_sublist(_, []), do: :error
  def check_sublist(closing_bracket, [h | t]) do
    if h == closing_bracket do
      {:ok, t}
    else
      case get_closing_bracket(h) do
        :error -> :error
        {:ok, closing_bracket2} ->
          case check_sublist(closing_bracket2, t) do
            {:ok, t} -> check_sublist(closing_bracket, t)
            :error -> :error
          end
      end
    end
  end

  def get_closing_bracket(h) do
    case h do
      "{" -> {:ok, "}"}
      "[" -> {:ok, "]"}
      "(" -> {:ok, ")"}
      _   -> :error
    end
  end
end

#do_check_brackets("}", find_check_brackets("]", "]}"))
