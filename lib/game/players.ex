defmodule Game.Players do
  @moduledoc """
  The struct that holds each player with their corresponding information
  """

  alias __MODULE__
  alias Game.Player
  alias Game.PlayerType.HumanPlayer

  @type t :: %__MODULE__{}

  defstruct player_one: %Player{type: HumanPlayer, symbol: "X"}, player_two: %Player{type: HumanPlayer, symbol: "O"}

  @spec set_players(Player.t(), Player.t()) :: Game.Players.t()
  def set_players(player_one, player_two) do
    %Players{player_one: player_one, player_two: player_two}
  end

  @spec get_player(Players.t(), :player_one | :player_two) :: Player.t()
  def get_player(players, player_number) do
    Map.get(players, player_number)
  end
end
