defmodule Game.Players do
  @moduledoc """
  The struct that holds each player with their corresponding information
  """
  alias Game.Player
  alias Game.PlayerType.HumanPlayer

  defstruct player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: HumanPlayer, symbol: "O"}
end
