defmodule Game.PlayerType.HumanPlayer do
  @moduledoc """
  The module that handles a Human Players move
  """

  alias Game.Validator
  alias Game.PlayerType.PlayerBehaviour

  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(board, communicator) do
    player_input = String.trim(communicator.read_input("please make desired move: "))
    Validator.validate(board, player_input)
  end
end
