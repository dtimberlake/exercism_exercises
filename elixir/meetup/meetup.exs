defmodule Meetup do
  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    daynum = to_daynum(weekday)

    day = get_days_to_check(schedule, year, month)
          |> Enum.find(fn (n) ->
            :calendar.day_of_the_week(year, month, n) == daynum
          end)
    {year, month, day}
  end

  defp to_daynum(weekday) do
    case weekday do
      :monday    -> 1
      :tuesday   -> 2
      :wednesday -> 3
      :thursday  -> 4
      :friday    -> 5
      :saturday  -> 6
      :sunday    -> 7
    end
  end

  defp get_days_to_check(schedule, year, month) do
    case schedule do
      :first -> 1..7
      :second -> 8..14
      :third -> 15..21
      :fourth -> 22..28
      :last -> :calendar.last_day_of_the_month(year, month)..23
      :teenth -> 13..19
    end
  end
end
