defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO


  describe "start/1" do
    test "(integration test) displays welcome message and board" do
      assert capture_io(fn -> TicTacToe.start(CommandLine) end) =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """
    end

    test "(integration test) displays input message" do
      user_input = "1"
      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine)) end) =~
        "Please input desired placement: #{user_input}"
    end

    test "(unit test) displays welcome message and board" do
      start_supervised!(CommunicatorMock)

      assert TicTacToe.start(CommunicatorMock) =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """
    end

    test "(unit test) displays user input message" do
      start_supervised!(CommunicatorMock)

      user_input = "1"
      assert TicTacToe.start(CommunicatorMock) =~
        "Please input desired placement: #{user_input}"
    end
  end
end
