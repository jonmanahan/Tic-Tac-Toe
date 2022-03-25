defmodule BoardTest do
  use ExUnit.Case

  describe "setup_initial_board/1" do
    test "populates initial board with defaulted dimensions of 3, board length of 9" do
      assert Board.setup_initial_board() == %{
        1 => "1", 2 => "2", 3 => "3",
        4 => "4", 5 => "5", 6 => "6",
        7 => "7", 8 => "8", 9 => "9"
      }
    end

    test "populates initial board with dimensions of 2, board length of 4" do
      assert Board.setup_initial_board(2) == %{
        1 => "1", 2 => "2",
        3 => "3", 4 => "4"
      }
    end
  end

  describe "place_a_symbol/3" do
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

  describe "get_board_dimensions/1" do
    test "gets the dimensions of the board given a board of length 9" do
      board = %{
        1 => "1", 2 => "2", 3 => "3",
        4 => "4", 5 => "5", 6 => "6",
        7 => "7", 8 => "8", 9 => "9"
      }

      board_dimensions = Board.get_board_dimensions(board)

      assert board_dimensions === 3
    end

    test "gets the dimensions of the board given a board of length 4" do
      board = %{
        1 => "1", 2 => "2",
        3 => "3", 4 => "4"
      }

      board_dimensions = Board.get_board_dimensions(board)

      assert board_dimensions === 2
    end
  end

  describe "has_player_won?/1" do
    test "determines noone has won" do
      board = %{
        1 => "X", 2 => "2", 3 => "X",
        4 => "O", 5 => "5", 6 => "O",
        7 => "X", 8 => "8", 9 => "O"
      }

      assert Board.has_player_won?(board) === false
    end

    test "determines X is the winner in the diagonal direction" do
      board = %{
        1 => "X", 2 => "2", 3 => "X",
        4 => "O", 5 => "X", 6 => "O",
        7 => "X", 8 => "8", 9 => "O"
      }

      assert Board.has_player_won?(board) === true
    end

    test "determines X is the winner in the 3rd column" do
      board = %{
        1 => "X", 2 => "2", 3 => "X",
        4 => "O", 5 => "5", 6 => "X",
        7 => "X", 8 => "8", 9 => "X"
      }

      assert Board.has_player_won?(board) === true
    end

    test "determines X is the winner in the 3rd row" do
      board = %{
        1 => "X", 2 => "2", 3 => "X",
        4 => "O", 5 => "5", 6 => "O",
        7 => "X", 8 => "X", 9 => "X"
      }

      assert Board.has_player_won?(board) === true
    end
  end
end
