defmodule HardComputerPlayerTest do
  use ExUnit.Case

  alias Game.Player
  alias Game.PlayerType.HardComputerPlayer

  describe "valid_input/3" do
    test "returns the winning move for X given a board where X can immediately win" do
      player = %Player{type: HardComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "O", 3 => "X",
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 7}
    end

    test "returns move leading to tie for X given a board where X will tie or immediately lose" do
      player = %Player{type: HardComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "O", 6 => :empty,
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 2}
    end

    test "returns the next best available move for X given a board where X can't immediately win or tie" do
      player = %Player{type: HardComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => "X", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 1}
    end

    test "returns the winning move for O given a board where O can immediately win" do
      player = %Player{type: HardComputerPlayer, symbol: "O"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "O", 3 => :empty,
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => "X", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 3}
    end

    test "returns the winning move for O given a board where O can immediately win or tie" do
      player = %Player{type: HardComputerPlayer, symbol: "O"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "O", 6 => "X",
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 2}
    end

    test "returns the tieing move for O given a board where O will tie or immediately lose" do
      player = %Player{type: HardComputerPlayer, symbol: "O"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "X", 6 => "O",
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 3}
    end

    test "returns one of the best available moves for O given a board where O can't immediately win or tie" do
      player = %Player{type: HardComputerPlayer, symbol: "O"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 1}
    end

    test "returns the best available move for X given a starting board" do
      player = %Player{type: HardComputerPlayer, symbol: "X"}

      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(player, board, CommunicatorMock) == {:ok, 1}
    end
  end
end
