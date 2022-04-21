defmodule Game.PlayerType.PlayerBehaviour do
  @moduledoc """
  The module that defines a generic players functions
  """
  @callback valid_input(board :: map(), current_symbol :: String.t(), communicator :: any()) :: tuple()
end
