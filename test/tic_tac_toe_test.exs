defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  describe "start/1" do
    test "(end to end test) displays the starting board and the end board with a winning message for X given corresponding inputs" do
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

    test "(end to end test) displays the end board with a winning message for O given a fresh start and corresponding inputs" do
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

    test "(end to end test) displays the end board with a tied message given a fresh start and corresponding inputs" do
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

    test "(integration test) displays welcome message and board when first called" do
      user_input = "1"

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter, board)) end) =~
        """
        Welcome to Tic-Tac-Toe

        1 | X | X
        --|---|--
        4 | O | O
        --|---|--
        7 | 8 | 9
        """
    end

    test "(integration test) displays the corresponding board after a valid move" do
      user_input = "4"

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => "X", 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter, board)) end) =~
        """
        1 | X | X
        --|---|--
        O | O | O
        --|---|--
        7 | X | 9
        """
    end

    test "(integration test) displays the corresponding error message after an invalid move" do
      user_input = [input: "non valid move\n7\n"]

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => "O", 5 => "X", 6 => "O",
        7 => :empty, 8 => "O", 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter, board)) end) =~
        "Invalid input, please input a number between 1 and 9"
    end

    test "(integration test) displays the corresponding end game message after a valid game ending move" do
      user_input = "2"

      board = %{
        1 => "O", 2 => :empty, 3 => "X",
        4 => "X", 5 => "X", 6 => "O",
        7 => "O", 8 => "O", 9 => "X"
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter, board)) end) =~
        "No player has won, tie!\n"
    end

    test "(integration test) displays that it is O's turn after X makes a valid move" do
      user_input = [input: "2\n7\n"]

      board = %{
        1 => :empty, 2 => :empty, 3 => "O",
        4 => "X", 5 => "O", 6 => "X",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert capture_io(user_input, fn -> IO.write(TicTacToe.start(CommandLine, CommandLineFormatter, board)) end) =~
        """
        1 | 2 | O
        --|---|--
        X | O | X
        --|---|--
        7 | 8 | 9

        Player X, Please input desired placement:\s
        1 | X | O
        --|---|--
        X | O | X
        --|---|--
        7 | 8 | 9

        Player O, Please input desired placement:\s
        """
    end

    test "(unit test) displays welcome message and board when start is first called" do
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

    test "(unit test) displays user input message when X's turn" do
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

    test "(unit test) displays user input message when O's turn" do
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

    test "(unit test) displays X's winning message" do
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

    test "(unit test) displays O's winning message" do
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

    test "(unit test) displays out of bounds validation message via first input, then displays updated board via second" do
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

    test "(unit test) displays space taken validation message via first input, then displays updated board via second" do
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
