defmodule GameSetupTest do
  use ExUnit.Case

  alias Game.GameSetup
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer

  describe "setup_players/1" do
    test "returns players containing both player's with their types that were determined via user input and symbols" do
      user_inputs = ["1", "2"]
      start_supervised!({CommunicatorMock, user_inputs})

      assert GameSetup.setup_players(CommunicatorMock) ==
        %Players{player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}
    end
  end
end
