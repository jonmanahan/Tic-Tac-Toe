defmodule CommandLineFormatterTest do
  use ExUnit.Case

  describe "format_board/1" do
    test "converts the board into a CommandLine display friendly format" do
      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
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
