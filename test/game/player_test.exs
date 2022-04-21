defmodule PlayerTest do
  use ExUnit.Case

  alias Game.Player
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Communication.CommandLine

  @mock_command_line %CommandLine{communicator: CommunicatorMock}

  describe "create_player/2" do
    test "returns a newly created human player with an associated player type and symbol" do
      assert Player.create_player(HumanPlayer, "X") == %Player{type: HumanPlayer, symbol: "X"}
    end

    test "returns a newly created an easy computer player with an associated player type and symbol" do
      assert Player.create_player(EasyComputerPlayer, "O") == %Player{type: EasyComputerPlayer, symbol: "O"}
    end
  end

  describe "get_move/3" do
    test "returns a players valid move" do
      user_input = "1"
      start_supervised!({@mock_command_line.communicator, [user_input]})

      player = %Player{type: HumanPlayer, symbol: "X"}

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert {:ok, 1} = Player.get_move(player, board, @mock_command_line.communicator)
    end

    test "returns a players invalid move" do
      user_input = "12"
      start_supervised!({@mock_command_line.communicator, [user_input]})

      player = %Player{type: HumanPlayer, symbol: "X"}

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert {:invalid, :out_of_bounds} = Player.get_move(player, board, @mock_command_line.communicator)
    end
  end
end
