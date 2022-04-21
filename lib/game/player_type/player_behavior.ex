defmodule Game.PlayerType.PlayerBehaviour do
  @moduledoc """
  The module that defines a generic players functions
  """
  @callback valid_input(player :: Player.t(), board :: map(), communicator :: any()) :: tuple()
end
