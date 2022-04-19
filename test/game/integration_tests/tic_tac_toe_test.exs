defmodule TicTacToeIntegrationTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Game.TicTacToe
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.EasyComputerPlayer
  alias Communication.CommandLine

  @human_players %Players{}

  describe "start/1" do
    test "displays the corresponding board after a valid move" do
      user_input = "4"

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => "X", 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(%CommandLine{}, board, @human_players)) end) =~
        """
        1 | X | X
        --|---|--
        O | O | O
        --|---|--
        7 | X | 9
        """
    end

    test "displays the corresponding error message after an invalid move" do
      user_input = [input: "non valid move\n7\n"]

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => "O", 5 => "X", 6 => "O",
        7 => :empty, 8 => "O", 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(%CommandLine{}, board, @human_players)) end) =~
        "Invalid input, please input a number between 1 and 9"
    end

    test "displays the corresponding end game message after a valid game ending move" do
      user_input = "2"

      board = %{
        1 => "O", 2 => :empty, 3 => "X",
        4 => "X", 5 => "X", 6 => "O",
        7 => "O", 8 => "O", 9 => "X"
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(%CommandLine{}, board, @human_players)) end) =~
        "No player has won, tie!\n"
    end

    test "displays that it is O's turn after X makes a valid move" do
      user_input = [input: "2\n7\n"]

      board = %{
        1 => :empty, 2 => :empty, 3 => "O",
        4 => "X", 5 => "O", 6 => "X",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(%CommandLine{}, board, @human_players)) end) =~
        """
        Player X, please make desired move:\s
        1 | X | O
        --|---|--
        X | O | X
        --|---|--
        7 | 8 | 9

        Player O, please make desired move:\s
        """
    end

    test "displays easy computers move decision (next possible move) and the resulting updated board after human turn" do
      user_input = [input: "2\n"]

      board = %{
        1 => "O", 2 => :empty, 3 => "X",
        4 => :empty, 5 => :empty, 6 => "X",
        7 => "O", 8 => :empty, 9 => :empty
      }

      players = %Players{player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(%CommandLine{}, board, players)) end) =~
        """
        Player O, please make desired move (Computer): 4

        O | X | X
        --|---|--
        O | 5 | X
        --|---|--
        O | 8 | 9
        """
    end
  end
end
