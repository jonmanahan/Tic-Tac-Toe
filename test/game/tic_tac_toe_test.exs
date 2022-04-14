defmodule TicTacToeTest do
  use ExUnit.Case, async: true

  alias Game.TicTacToe
  alias Game.Player.HumanPlayer
  alias Game.Player.EasyComputerPlayer
  alias Communication.CommandLine.CommandLineFormatter

  @human_players %{"X" => HumanPlayer, "O" => HumanPlayer}

  describe "start/1" do
    test "displays user input message when X's turn" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player X, please make desired move: #{user_input}"
    end

    test "displays user input message when O's turn" do
      user_input = ["4"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => "X", 9 => :empty
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player O, please make desired move: #{user_input}"
    end

    test "displays X's winning message" do
      user_input = ["1"]
      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => :empty, 9 => "O"
      }

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, @human_players)

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

    test "displays computers move message (next available spot) after human turn, then displays updated board" do
      user_inputs = ["2"]
      start_supervised!({CommunicatorMock, user_inputs})

      board = %{
        1 => :empty, 2 => :empty, 3 => "X",
        4 => :empty, 5 => "O", 6 => "X",
        7 => :empty, 8 => :empty, 9 => "O"
      }

      players = %{"X" => HumanPlayer, "O" => EasyComputerPlayer}

      TicTacToe.start(CommunicatorMock, CommandLineFormatter, board, players)

      assert :sys.get_state(CommunicatorMockServer) =~
        "Player O, please make desired move (Computer): 1"
      assert :sys.get_state(CommunicatorMockServer) =~
        """
        O | X | X
        --|---|--
        4 | O | X
        --|---|--
        7 | 8 | O
        """
    end
  end
end
