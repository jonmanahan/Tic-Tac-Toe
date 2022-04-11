defmodule MessageTest do
  use ExUnit.Case

  alias Game.Message

  describe "game_status/1" do
    test "returns a tie message when noone has won and the board is full" do
      player_symbol = "X"

      board = %{
        1 => "O", 2 => "X", 3 => "X",
        4 => "X", 5 => "O", 6 => "O",
        7 => "O", 8 => "X", 9 => "X"
      }

      assert Message.game_status(board, player_symbol) == "No player has won, tie!\n"
    end

    test "returns an X is the winner message when three X's in a row is achieved" do
      player_symbol = "X"

      board = %{
        1 => "O", 2 => :empty, 3 => "X",
        4 => "X", 5 => "X", 6 => "X",
        7 => "O", 8 => :empty, 9 => "O"
      }

      assert Message.game_status(board, player_symbol) == "Player #{player_symbol} has Won!\n"
    end

    test "returns an O is the winner message when three O's in a row is achieved" do
      player_symbol = "O"

      board = %{
        1 => "O", 2 => "X", 3 => "X",
        4 => "X", 5 => :empty, 6 => "X",
        7 => "O", 8 => "O", 9 => "O"
      }

      assert Message.game_status(board, player_symbol) == "Player #{player_symbol} has Won!\n"
    end

    test "returns an empty message when the game is still in progress" do
      player_symbol = "O"

      board = %{
        1 => "O", 2 => :empty, 3 => "X",
        4 => "X", 5 => :empty, 6 => "X",
        7 => "O", 8 => :empty, 9 => "O"
      }

      assert Message.game_status(board, player_symbol) == ""
    end
  end

  describe "invalid_input/1" do
    test "returns an invalid input message when given a non-numerical input status" do
      invalid_input_status = :non_numerical

      assert Message.invalid_input(invalid_input_status) == "Invalid input, please input a number between 1 and 9\n"
    end

    test "returns an invalid input message when given a out of bounds input status" do
      invalid_input_status = :out_of_bounds

      assert Message.invalid_input(invalid_input_status) == "Invalid input, number out of bounds\n"
    end

    test "returns an invalid input message when given a space taken input status" do
      invalid_input_status = :space_taken

      assert Message.invalid_input(invalid_input_status) == "Invalid input, position has already been taken\n"
    end
  end
end
