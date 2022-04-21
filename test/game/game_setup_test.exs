defmodule GameSetupTest do
  use ExUnit.Case

  alias Game.GameSetup
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Communication.CommandLine

  @mock_command_line %CommandLine{communicator: CommunicatorMock}

  describe "setup_players/1" do
    test "returns players containing a Human player 1 and Human player 2 with their assosciated symbols" do
      user_inputs = ["1", "1"]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: HumanPlayer, symbol: "O"}}
    end

    test "returns players containing a Human player 1 and Computer player 2 with their assosciated symbols" do
      user_inputs = ["1", "2"]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}
    end

    test "returns players containing a Computer player 1 and Human player 2 with their assosciated symbols" do
      user_inputs = ["2", "1"]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{player_one: %Player{type: EasyComputerPlayer, symbol: "X"}, player_two: %Player{type: HumanPlayer, symbol: "O"}}
    end

    test "returns players containing a Computer player 1 and Computer player 2 with their assosciated symbols" do
      user_inputs = ["2", "2"]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{player_one: %Player{type: EasyComputerPlayer, symbol: "X"}, player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}
    end
  end
end