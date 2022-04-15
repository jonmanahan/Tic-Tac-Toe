defmodule Game.Player do
  @moduledoc """
  The struct that holds a single players information
  """
  alias Game.PlayerType.HumanPlayer

  defstruct type: HumanPlayer, symbol: ""
end
