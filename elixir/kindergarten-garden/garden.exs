defmodule Garden do
  @children [:alice, :bob, :charlie, :david, :eve, :fred, :ginny,
             :harriet, :ileana, :joseph, :kincaid, :larry
            ]
  @plants %{
    ?V => :violets,
    ?G => :grass,
    ?R => :radishes,
    ?C => :clover
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @children) do
    student_names = sort_names(student_names)

    info_string
    |> plants_to_students(student_names)
    |> ensure_all_students_have_record(student_names)
  end

  defp sort_names(names) do
    names
    |> Enum.map(&Atom.to_string&1)
    |> Enum.sort
    |> Enum.map(&String.to_atom&1)
  end

  defp plants_to_students(info_string, student_names) do
    info_string
    |> String.split("\n")
    |> Enum.map(&String.to_charlist&1)
    |> Enum.map(&Enum.chunk(&1, 2))
    |> List.zip
    |> Enum.map(&Tuple.to_list&1)
    |> Enum.map(&List.flatten&1)
    |> Enum.map(&Enum.map(&1, fn (x) -> Map.get(@plants, x) end))
    |> Enum.map(&List.to_tuple&1)
    |> Enum.zip(student_names)
    |> Enum.map(fn ({a, b}) -> {b, a} end )
    |> Map.new
  end

  defp ensure_all_students_have_record(student_plants, student_names) do
    student_names
    |> Enum.reduce(%{}, fn (name, acc) ->
      Map.put(acc, name, Map.get(student_plants, name, {}))
    end)
  end
end
