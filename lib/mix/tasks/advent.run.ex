defmodule Mix.Tasks.Advent.Run do
  use Mix.Task

  def run([day, part | rest]) do
    Application.ensure_all_started(:advent)

    year = System.get_env("AOC_YEAR")
    year
    |> Advent.read(day)
    |> run_part(year, day, part, rest)
    |> IO.inspect(label: :output)
  end

  defp run_part(input, year, day, part, args) do
    mod = :"Elixir.Advent.Year#{year}.Day#{padded_day(day)}"
    func = :"part#{part}"

    # this means that the functions need to be able to always handle strings
    apply(mod, func, [input | args])
  end

  defp padded_day(day) do
    day
    |> to_string
    |> String.pad_leading(2, "0")
  end
end
