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
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

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
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      TicTacToe.start(CommunicatorMock, CommandLineFormatter)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Please input desired placement: #{user_input}"
    end

    test "(unit test) displays winning message" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => :empty, 9 => "O"
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player X has Won!"
    end

    test "(unit test) displays tie message" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "O", 3 => "X",
        4 => "O", 5 => "O", 6 => "X",
        7 => "X", 8 => "X", 9 => "O"
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "No player has won, tie!"
    end

    test "(unit test) displays non-numerical validation message via first input, then displays updated board via second" do
      user_inputs = ["this is not a numerical input", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, please input a number between 1 and 9\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | 2 | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9
      """
    end

    test "(unit test) displays out of bounds validation message via first input, then displays updated board via second" do
      user_inputs = ["12", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, number out of bounds\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | 2 | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9
      """
    end

    test "(unit test) displays space taken validation message via first input, then displays updated board via second" do
      user_inputs = ["2", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => "X", 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, position has already been taken\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | X | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9
      """
    end

  end
end
