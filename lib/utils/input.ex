defmodule Advent2020.Utils.Input do
  @input_dir "priv/inputs"
  def download(day) do
    :get
    |> Finch.build("https://adventofcode.com/2020/day/#{day}/input",  [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}])
    |> Finch.request(AdventFinch)
    |> case do
      {:ok, %{status: 200, body: body}} ->
        :ok = File.mkdir_p(@input_dir)
        :ok = File.write(path(day), body)
        body
      error -> error
    end
  end

  def read(day) do
    day
    |> path()
    |> File.exists?()
    |> case do
      true ->
        day
        |> path()
        |> File.read!()
        |> String.trim()
      _ ->
        day
        |> download()
        |> String.trim()
    end
  end

  def lines_to_ints(data), do: split_to_ints(data, "\n")

  def csv_to_ints(data), do: split_to_ints(data, ",")

  defp split_to_ints(data, sep) do
    data
    |> String.trim()
    |> String.split(sep, trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp path(day), do: Path.join(@input_dir, "#{day}.txt")
end
