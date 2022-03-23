defmodule BoardTest do
  use ExUnit.Case

  describe "board/0" do

    test "populates initial board" do
      assert Board.setup_initial_board() ===
        %{1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9"}
    end

    test "converts the board into a CommandLine display friendly format" do
      unformatted_board = Board.setup_initial_board()

      assert Board.format_board_to_display(unformatted_board) ===
      """

      1 | 2 | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9

      """
    end

    test "replaces the 2 with an X" do
      unformatted_board = Board.setup_initial_board()

      unformatted_board = Board.update_board(unformatted_board, "2", "X")

      assert Board.format_board_to_display(unformatted_board) ===
      """

      1 | X | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9

      """
    end
  end
end
