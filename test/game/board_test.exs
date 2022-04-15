defmodule BoardTest do
  use ExUnit.Case

  alias Game.Board

  describe "setup_initial_board/1" do
    test "populates initial board with defaulted dimensions of 3, board length of 9" do
      assert Board.setup_initial_board() == %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }
    end

    test "populates initial board with dimensions of 2, board length of 4" do
      assert Board.setup_initial_board(2) == %{
        1 => :empty, 2 => :empty,
        3 => :empty, 4 => :empty
      }
    end
  end

  describe "place_a_symbol/3" do
    test "replaces the :empty with an X" do
      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      board = Board.place_a_symbol(board, 2, "X")

      expected_board = %{
        1 => :empty, 2 => "X", 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert board == expected_board
    end
  end

  describe "board_dimensions/1" do
    test "gets the dimensions of the board given a board of length 9" do
      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      board_dimensions = Board.board_dimensions(board)

      assert board_dimensions == 3
    end

    test "gets the dimensions of the board given a board of length 4" do
      board = %{
        1 => :empty, 2 => :empty,
        3 => :empty, 4 => :empty
      }

      board_dimensions = Board.board_dimensions(board)

      assert board_dimensions == 2
    end
  end

  describe "game_status/1" do
    test "determines game has not been won or tied" do
      board = %{
        1 => "X", 2 => :empty, 3 => "X",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => :empty, 9 => "O"
      }

      assert Board.game_status(board) == :in_progress
    end

    test "determines X is the winner in the diagonal direction" do
      board = %{
        1 => "X", 2 => :empty, 3 => "X",
        4 => "O", 5 => "X", 6 => "O",
        7 => "X", 8 => :empty, 9 => "O"
      }

      assert Board.game_status(board) == :won
    end

    test "determines X is the winner in the 3rd column" do
      board = %{
        1 => "X", 2 => :empty, 3 => "X",
        4 => "O", 5 => :empty, 6 => "X",
        7 => "X", 8 => :empty, 9 => "X"
      }

      assert Board.game_status(board) == :won
    end

    test "determines X is the winner in the 3rd row" do
      board = %{
        1 => "X", 2 => :empty, 3 => "X",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => "X", 9 => "X"
      }

      assert Board.game_status(board) == :won
    end

    test "determines there is a winner even with a full board" do
      board = %{
        1 => "X", 2 => "X", 3 => "X",
        4 => "O", 5 => "O", 6 => "X",
        7 => "X", 8 => "O", 9 => "O"
      }

      assert Board.game_status(board) == :won
    end

    test "determines there is a tie" do
      board = %{
        1 => "X", 2 => "O", 3 => "O",
        4 => "O", 5 => "X", 6 => "X",
        7 => "X", 8 => "O", 9 => "O"
      }

      assert Board.game_status(board) == :tied
    end
  end

  describe "move_status/1" do
    test "indicates the move is out of bounds (upper bounds)" do
      user_input = 12

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.move_status(board, user_input) == :out_of_bounds
    end

    test "indicates the move is out of bounds (lower bounds)" do
      user_input = 0

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.move_status(board, user_input) == :out_of_bounds
    end

    test "indicates the move is out of bounds on a 2x2 board" do
      user_input = 5

      board = %{
        1 => :empty, 2 => :empty,
        3 => :empty, 4 => :empty
      }

      assert Board.move_status(board, user_input) == :out_of_bounds
    end

    test "indicated the space is already taken" do
      user_input = 2

      board = %{
        1 => :empty, 2 => "X", 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.move_status(board, user_input) == :space_taken
    end

    test "indicates the move is valid" do
      user_input = 4

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.move_status(board, user_input) == :valid
    end
  end

  describe "calculate_turn/1" do
    test "determines the first move is X's turn given an empty board" do
      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.calculate_turn(board) == :player_one
    end

    test "determines the second move is O’s turn given a board with one X" do
      board = %{
        1 => "X", 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert Board.calculate_turn(board) == :player_two
    end

    test "determines its X's turn when there are the same number of X's and O'x on the board" do
      board = %{
        1 => "X", 2 => :empty, 3 => "O",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => :empty, 9 => "X"
      }

      assert Board.calculate_turn(board) == :player_one
    end

    test "determines its O's turn when there are the not same number of X's and O'x on the board" do
      board = %{
        1 => "O", 2 => :empty, 3 => "O",
        4 => "X", 5 => :empty, 6 => "X",
        7 => "X", 8 => "X", 9 => "O"
      }

      assert Board.calculate_turn(board) == :player_two
    end
  end

  describe "available_spaces/1" do
    test "" do
      board = %{
        1 => "O", 2 => :empty, 3 => "O",
        4 => "X", 5 => :empty, 6 => "X",
        7 => "X", 8 => "X", 9 => :empty
      }

      assert Board.available_spaces(board) == %{2 => :empty, 5 => :empty, 9 => :empty}
    end
  end
end
