defmodule Game.Player.EasyComputerPlayer do
  @moduledoc """
  The module that handles an Easy Computer Players move
  """

  alias Game.Player.PlayerBehaviour
  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(board, communicator) do
    valid_move = board
    |> Map.filter(fn {_key, val} -> val == :empty end)
    |> Map.keys()
    |> List.first()
    communicator.display("please make desired move (Computer): #{valid_move}\n")
    {:ok, valid_move}
  end
end
