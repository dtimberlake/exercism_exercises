defmodule Words do
  import String
  import List, only: [foldr: 3]
  import Map, only: [update: 4]

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    words =
      sentence
      |> String.replace(~r/_/, " ")
      |> String.replace(~r/[.,\/#!$%\^&\*;:{}=`~()@]/, "")
      |> String.downcase
      |> String.split

    foldr words, %{}, fn(x, acc) ->
      update(acc, x, 1, &(&1 + 1))
    end
  end
end
