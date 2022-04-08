defmodule TicTacToeTest do
  use ExUnit.Case

  describe "start/1" do
    test "displays welcome message and board when start is first called" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        """
        Welcome to Tic-Tac-Toe

        1 | X | X
        --|---|--
        4 | O | O
        --|---|--
        7 | 8 | 9
        """
    end

    test "displays user input message when X's turn" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player X, Please input desired placement: #{user_input}"
    end

    test "displays user input message when O's turn" do
      user_input = ["4"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => "X", 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player O, Please input desired placement: #{user_input}"
    end

    test "displays X's winning message" do
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

    test "displays O's winning message" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "O", 3 => "O",
        4 => "O", 5 => "X", 6 => "X",
        7 => "X", 8 => :empty, 9 => "X"
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player O has Won!"
    end

    test "displays tie message" do
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

    test "displays non-numerical validation message via first input, then displays updated board via second" do
      user_inputs = ["this is not a numerical input", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, please input a number between 1 and 9\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

    test "displays out of bounds validation message via first input, then displays updated board via second" do
      user_inputs = ["12", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, number out of bounds\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

    test "displays space taken validation message via first input, then displays updated board via second" do
      user_inputs = ["2", "1"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Invalid input, position has already been taken\n"
      assert :sys.get_state(CommunicatorMockServer) =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

  end
end
