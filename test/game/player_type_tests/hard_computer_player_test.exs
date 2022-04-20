defmodule HardComputerPlayerTest do
  use ExUnit.Case

  alias Game.PlayerType.HardComputerPlayer

  describe "valid_input/2" do
    @tag :skip
    test "returns the winning move for X given a board where X can immediately win" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "O", 3 => "X",
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 7}
    end

    @tag :skip
    test "returns move leading to tie for X given a board where X will tie or immediately lose" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "O", 6 => :empty,
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 2}
    end

    @tag :skip
    test "returns one of the best available moves for X given a board where X can't immediately win or tie" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => "X", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 1} || {:ok, 3} || {:ok, 7} || {:ok, 9}
    end

@tag :skip
    test "returns the winning move for O given a board where O can immediately win" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => "O", 3 => :empty,
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => "X", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 3}
    end

    @tag :skip
    test "returns the winning move for O given a board where O can immediately win or tie" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "O", 6 => "X",
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 2}
    end

    @tag :skip
    test "returns the tieing move for O given a board where O will tie or immediately lose" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => "O", 2 => :empty, 3 => :empty,
        4 => "X", 5 => "X", 6 => "O",
        7 => "X", 8 => "O", 9 => "X"
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 3}
    end

    @tag :skip
    test "returns one of the best available moves for O given a board where O can't immediately win or tie" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => "X", 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 1} || {:ok, 3} || {:ok, 7} || {:ok, 9}
    end

    @tag :skip
    test "returns the best available move for X given a starting board" do
      start_supervised!(CommunicatorMock)

      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HardComputerPlayer.valid_input(board, CommunicatorMock) == {:ok, 5}
    end
  end
end
