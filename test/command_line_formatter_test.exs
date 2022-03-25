defmodule CommandLineFormatterTest do
  use ExUnit.Case

  describe "format_board/1" do
    test "converts the board into a CommandLine display friendly format" do
      board = %{
        1 => "1", 2 => "2", 3 => "3",
        4 => "4", 5 => "5", 6 => "6",
        7 => "7", 8 => "8", 9 => "9"
      }

      assert CommandLineFormatter.format_board(board) ===
      """

      1 | 2 | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9

      """
    end
  end
end
