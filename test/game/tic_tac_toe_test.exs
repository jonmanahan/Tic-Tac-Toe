defmodule TicTacToeTest do
  use ExUnit.Case, async: true

  alias Game.TicTacToe
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.EasyComputerPlayer
  alias Communication.CommandLine

  @human_players %Players{}
  @mock_command_line %CommandLine{communicator: CommunicatorMock}

  describe "start/1" do
    test "displays user input message when X's turn" do
      user_input = "1"
      setup_mock([user_input])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Player X, please make desired move: #{user_input}"
    end

    test "displays user input message when O's turn" do
      user_input = "4"
      setup_mock([user_input])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => "X", 9 => :empty
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Player O, please make desired move: #{user_input}"
    end

    test "displays X's winning message" do
      setup_mock(["1"])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => "O", 5 => :empty, 6 => "O",
        7 => "X", 8 => :empty, 9 => "O"
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Player X has Won!"
    end

    test "displays O's winning message" do
      setup_mock(["1"])

      board = %{
        1 => :empty, 2 => "O", 3 => "O",
        4 => "O", 5 => "X", 6 => "X",
        7 => "X", 8 => :empty, 9 => "X"
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Player O has Won!"
    end

    test "displays tie message" do
      setup_mock(["1"])

      board = %{
        1 => :empty, 2 => "O", 3 => "X",
        4 => "O", 5 => "O", 6 => "X",
        7 => "X", 8 => "X", 9 => "O"
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "No player has won, tie!"
    end

    test "displays non-numerical validation message via first input, then displays updated board via second" do
      setup_mock(["this is not a numerical input", "1"])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Invalid input, please input a number between 1 and 9\n"
      assert CommunicatorMock.get_message_history() =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

    test "displays out of bounds validation message via first input, then displays updated board via second" do
      setup_mock(["12", "1"])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Invalid input, number out of bounds\n"
      assert CommunicatorMock.get_message_history() =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

    test "displays space taken validation message via first input, then displays updated board via second" do
      setup_mock(["2", "1"])

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      TicTacToe.start(@mock_command_line, board, @human_players)

      assert CommunicatorMock.get_message_history() =~
        "Invalid input, position has already been taken\n"
      assert CommunicatorMock.get_message_history() =~
      """
      X | X | X
      --|---|--
      4 | O | O
      --|---|--
      7 | 8 | 9
      """
    end

    test "displays computers move message (next available spot) after human turn, then displays updated board" do
      setup_mock(["2"])

      board = %{
        1 => :empty, 2 => :empty, 3 => "X",
        4 => :empty, 5 => "O", 6 => "X",
        7 => :empty, 8 => :empty, 9 => "O"
      }

      players = %Players{player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}

      TicTacToe.start(@mock_command_line, board, players)

      assert CommunicatorMock.get_message_history() =~
        "Player O, please make desired move (Computer): 1"
      assert CommunicatorMock.get_message_history() =~
        """
        O | X | X
        --|---|--
        4 | O | X
        --|---|--
        7 | 8 | O
        """
    end
  end

  defp setup_mock(user_inputs) do
    start_supervised!({@mock_command_line.communicator, user_inputs})
  end
end
