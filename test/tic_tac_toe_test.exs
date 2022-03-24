defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "start/1" do
    test "(integration test) displays welcome message and board" do
      user_input = "1"
      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter)) end) =~
        """
        Welcome to Tic-Tac-Toe

        1 | 2 | 3
        --|---|--
        4 | 5 | 6
        --|---|--
        7 | 8 | 9
        """
    end

    test "(unit test) displays welcome message and board" do
      start_supervised!(CommunicatorMock)

      TicTacToe.start(CommunicatorMock, CommandLineFormatter)

      assert :sys.get_state(CommunicatorMockServer) =~
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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter)
      user_input = "1"

      assert :sys.get_state(CommunicatorMockServer) =~
        "Please input desired placement: #{user_input}"
    end
  end
end
