defmodule BoardTest do
  use ExUnit.Case

  test "populates initial board" do
    assert Board.setup_initial_board() === %{
      1 => "1", 2 => "2", 3 => "3",
      4 => "4", 5 => "5", 6 => "6",
      7 => "7", 8 => "8", 9 => "9"
    }
  end

  test "replaces the 2 with an X" do
    board = %{
      1 => "1", 2 => "2", 3 => "3",
      4 => "4", 5 => "5", 6 => "6",
      7 => "7", 8 => "8", 9 => "9"
    }

    board = Board.place_a_symbol(board, "2", "X")

    expected_board = %{
      1 => "1", 2 => "X", 3 => "3",
      4 => "4", 5 => "5", 6 => "6",
      7 => "7", 8 => "8", 9 => "9"
    }

    assert board == expected_board
  end
end
