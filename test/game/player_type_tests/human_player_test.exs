defmodule HumanPlayerTest do
  use ExUnit.Case

  alias Game.PlayerType.HumanPlayer

  describe "valid_input/3" do
    test "returns valid move given valid human player input" do
      user_input = ["1"]
      symbol = "X"

      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HumanPlayer.valid_input(board, symbol, CommunicatorMock) == {:ok, 1}
    end

    test "returns invalid move and reason given invalid human player input" do
      user_input = ["2"]
      symbol = "X"

      start_supervised!({CommunicatorMock, user_input})

      board = %{
        1 => :empty, 2 => "X", 3 => "X",
        4 => :empty, 5 => "O", 6 => "O",
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert HumanPlayer.valid_input(board, symbol, CommunicatorMock) == {:invalid, :space_taken}
    end
  end
end
