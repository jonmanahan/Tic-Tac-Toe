defmodule TicTacToeEndToEndTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Game.TicTacToe
  alias Communication.CommandLine.CommandLineFormatter
  alias Communication.CommandLine.CommandLineCommunicator

  describe "start/1" do
    test "expects a game to end with a player winning" do
      user_input = [input: "1\n1\n1\n2\n3\n4\n5\n6\n7\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLineCommunicator, CommandLineFormatter)) end)

      assert game_play =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """

      assert game_play =~
        """
        X | O | X
        --|---|--
        O | X | O
        --|---|--
        X | 8 | 9

        Player X has Won!
        """
    end

    test "expects a game to end with a player tieing" do
      user_input = [input: "1\n1\n1\n2\n3\n4\n6\n5\n7\n9\n8\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLineCommunicator, CommandLineFormatter)) end)

      assert game_play =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """

      assert game_play =~
        """
        X | O | X
        --|---|--
        O | O | X
        --|---|--
        X | X | O

        No player has won, tie!
        """
    end

    test "expects a game to be setup with user selected players and played out" do
      user_input = [input: "1\n2\n1\n3\n5\n7\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLineCommunicator, CommandLineFormatter)) end)

      assert game_play =~ "Please select Player 1 (X) => 1 - Human, 2 - Computer:\s"

      assert game_play =~ "Please select Player 2 (O) => 1 - Human, 2 - Computer:\s"

      assert game_play =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """

      assert game_play =~
        """
        X | O | X
        --|---|--
        O | X | O
        --|---|--
        X | 8 | 9

        Player X has Won!
        """
    end
  end
end
