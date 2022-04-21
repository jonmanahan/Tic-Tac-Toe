defmodule EasyComputerPlayerTest do
  use ExUnit.Case

  alias Game.Player
  alias Game.PlayerType.EasyComputerPlayer

  describe "valid_input/3" do
    test "returns first available move" do
      player = %Player{type: EasyComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert EasyComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 1}
    end

    test "returns next available move" do
      player = %Player{type: EasyComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => "X", 8 => "X", 9 => :empty
      }

      assert EasyComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 4}
    end
  end
end
