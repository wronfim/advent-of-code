defmodule Mix.Tasks.Day.Setup do
  use Mix.Task

  def run([day]) do
    Application.ensure_all_started(:advent2020)
    # download the input
    Advent2020.Utils.Input.download(day)

    # generate a test file
    {day, contents} = test_file_contents(day)

    if not File.exists?("test/day_#{day}_test.exs") do
      File.mkdir_p("test")
      File.write("test/day_#{day}_test.exs", contents)
    end

    {day, contents} = source_file_contents(day)

    if not File.exists?("lib/advent2020/day_#{day}.ex") do
      File.mkdir_p("lib/advent2020")
      File.write("lib/advent2020/day_#{day}.ex", contents)
    end
  end

  defp test_file_contents(day) do
    day =
      day
      |> to_string
      |> String.pad_leading(2, "0")

    contents =
      """
      defmodule Advent2020.Day#{day}Test do
        use ExUnit.Case

        import Advent2020.Day#{day}

        test "part1" do
        end

        @tag :skip
        test "part2" do
        end
      end
      """
      |> String.trim()

    {day, contents}
  end

  defp source_file_contents(day) do
    day =
      day
      |> to_string
      |> String.pad_leading(2, "0")

    contents = """
    defmodule Advent2020.Day#{day} do
      def part1 do
      end

      def part2 do
      end
    end
    """

    {day, contents}
  end
end
