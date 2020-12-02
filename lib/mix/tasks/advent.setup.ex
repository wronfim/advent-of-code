defmodule Mix.Tasks.Advent.Setup do
  require Logger
  use Mix.Task

  def run([day]) do
    Application.ensure_all_started(:advent)
    # download the input
    year = System.get_env("AOC_YEAR")

    case Advent.download(year, day) do
      {:error, error} -> Logger.error(error)
      {:ok, _body} ->
        # generate a test file
        {year, day, contents} = test_file_contents(year, day)

        if not File.exists?("test/year_#{year}/day_#{day}_test.exs") do
          File.mkdir_p("test/year_#{year}")
          File.write("test/year_#{year}/day_#{day}_test.exs", contents)
        end

        {year, day, contents} = source_file_contents(year, day)

        if not File.exists?("lib/advent/year_#{year}/day_#{day}.ex") do
          File.mkdir_p("lib/advent/year_#{year}")
          File.write("lib/advent/year_#{year}/day_#{day}.ex", contents)
        end
    end
  end

  defp test_file_contents(year, day) do
    day =
      day
      |> to_string
      |> String.pad_leading(2, "0")

    contents =
      """
      defmodule Advent.Year#{year}.Day#{day}Test do
        use ExUnit.Case

        import Advent.Year#{year}.Day#{day}

        test "part1" do
          assert part1("input") == "Your Answer."
        end

        test "part2" do
          assert part1("input") == "Your Answer."
        end
      end
      """
      |> String.trim()

    {year, day, contents}
  end

  defp source_file_contents(year, day) do
    day =
      day
      |> to_string
      |> String.pad_leading(2, "0")

    contents = """
    defmodule Advent.Year#{year}.Day#{day} do
      def part1(input) do
        "Your Answer."
      end

      def part2(input) do
        "Your Answer."
      end
    end
    """

    {year, day, contents}
  end
end
