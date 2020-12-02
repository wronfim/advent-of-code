defmodule Mix.Tasks.Day.Run do
  use Mix.Task

  def run([day, part | rest]) do
    Application.ensure_all_started(:advent2020)

    day
    |> Advent2020.Utils.Input.read()
    |> run_part(day, part, rest)
    |> IO.inspect(label: :output)
  end

  defp run_part(input, day, part, args) do
    mod = :"Elixir.Advent2020.Day#{padded_day(day)}"
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
