defmodule Game.Player do
  @moduledoc """
  The struct that holds a single players information
  """
  alias __MODULE__
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Game.PlayerType.HardComputerPlayer

  @type t :: %__MODULE__{}
  @typep player_type :: HumanPlayer | EasyComputerPlayer | HardComputerPlayer

  defstruct type: HumanPlayer, symbol: ""

  @spec create_player(player_type(), String.t()) :: Game.Player.t()
  def create_player(player_type, symbol) do
    %Player{type: player_type, symbol: symbol}
  end

  @spec get_move(Player.t(), map(), any) :: any
  def get_move(player, board, communicator) do
    player.type.valid_input(player, board, communicator)
  end
end
