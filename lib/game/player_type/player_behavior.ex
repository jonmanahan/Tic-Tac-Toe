defmodule Game.PlayerType.PlayerBehaviour do
  @moduledoc """
  The module that defines a generic players functions
  """

  alias Game.Player

  @callback valid_input(player :: Player.t(), board :: map(), communicator :: any()) :: tuple()
end
