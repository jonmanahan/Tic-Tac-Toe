defmodule PlayerTest do
  use ExUnit.Case

  alias Game.Player
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer

  describe "create_player/2" do
    test "returns a newly created human player with an associated player type and symbol" do
      assert Player.create_player(HumanPlayer, "X") == %Player{type: HumanPlayer, symbol: "X"}
    end

    test "returns a newly created an easy computer player with an associated player type and symbol" do
      assert Player.create_player(EasyComputerPlayer, "O") == %Player{type: EasyComputerPlayer, symbol: "O"}
    end
  end
end
