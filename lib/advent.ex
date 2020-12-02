defmodule Advent do
  @input_dir "priv/inputs"

  def download(year, day) do
    url = "https://adventofcode.com/#{year}/day/#{day}/input"
    headers = [{"cookie", "session=#{System.get_env("AOC_SESSION")}"}]

    :get
    |> Finch.build(url, headers)
    |> Finch.request(AdventFinch)
    |> case do
      {:ok, %{status: 200, body: body}} ->
        :ok = File.mkdir_p(path(year))
        :ok = File.write(path(year, day), body)
        {:ok, body}

      {:ok, %{status: 400, body: body}} ->
        {:error, body}

      error ->
        {:error, error}
    end
  end

  def read(year, day) do
    year
    |> path(day)
    |> File.exists?()
    |> case do
      true ->
        year
        |> path(day)
        |> File.read!()
        |> String.trim()
      _ ->
        year
        |> download(day)
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

  defp path(year), do: Path.join(@input_dir, "year_#{year}")
  defp path(year, day), do: Path.join(@input_dir, "year_#{year}/#{day}.txt")

end
