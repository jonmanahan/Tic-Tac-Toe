defmodule PlayersTest do
  use ExUnit.Case

  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer

  describe "set_players/2" do
    test "sets the user created player one and player two to their corresponding player number in players" do
      player_one = %Player{type: HumanPlayer, symbol: "X"}
      player_two = %Player{type: EasyComputerPlayer, symbol: "O"}

      assert Players.set_players(player_one, player_two) ==
        %Players{player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: EasyComputerPlayer, symbol: "O"}}
    end
  end
end
