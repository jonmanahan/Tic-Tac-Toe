defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO


  describe "start/1" do
    test "displays welcome message and board" do
      assert capture_io(fn -> TicTacToe.start(CommandLine) end) ===
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        """
    end

    test "displays welcome message and board using mock" do
      assert TicTacToe.start(CommandLineMock) ===
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        """
    end
  end
end
