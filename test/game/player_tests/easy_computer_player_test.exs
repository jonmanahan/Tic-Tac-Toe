defmodule EasyComputerPlayerTest do
  use ExUnit.Case

  alias Game.Player.EasyComputerPlayer

  describe "input/2" do
    test "returns first available move" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert EasyComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 1}
    end

    test "returns next available move" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => "X", 8 => "X", 9 => :empty
      }

      assert EasyComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 4}
    end
  end
end
