defmodule Game.Player.PlayerBehaviour do
  @moduledoc """
  The module that defines a generic players functions
  """
  @callback valid_input(board :: map(), communicator :: any()) :: tuple()
end
