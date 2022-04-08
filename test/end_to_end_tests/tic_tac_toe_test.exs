defmodule TicTacToeEndToEndTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "start/1" do
    test "displays the starting board and the end board with a winning message for X given corresponding inputs" do
      user_input = [input: "1\n2\n3\n4\n5\n6\n7\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter)) end)

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

    test "displays the end board with a winning message for O given a fresh start and corresponding inputs" do
      user_input = [input: "1\n2\n3\n5\n6\n8\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter)) end)

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
        4 | O | X
        --|---|--
        7 | O | 9

        Player O has Won!
        """
    end

    test "displays the end board with a tied message given a fresh start and corresponding inputs" do
      user_input = [input: "1\n2\n3\n4\n6\n5\n7\n9\n8\n"]

      game_play = capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter)) end)

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
  end
end
