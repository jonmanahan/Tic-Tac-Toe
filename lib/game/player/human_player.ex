defmodule Game.Player.HumanPlayer do
  @moduledoc """
  The module that handles a Human Players move
  """

  alias Game.Validator
  alias Game.Player.PlayerBehaviour
  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(board, communicator) do
    player_input = String.trim(communicator.read_input())
    Validator.validate(board, player_input)
  end
end
