defmodule Game.PlayerType.EasyComputerPlayer do
  @moduledoc """
  The module that handles an Easy Computer Players move
  """

  alias Game.PlayerType.PlayerBehaviour
  alias Game.Board

  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(board, symbol, communicator) do
    valid_move = board
    |> Board.available_spaces()
    |> Map.keys()
    |> List.first()

    communicator.display("Player #{symbol}, please make desired move (Computer): #{valid_move}\n")

    {:ok, valid_move}
  end
end
