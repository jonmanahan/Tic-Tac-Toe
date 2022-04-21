defmodule Game.Player do
  @moduledoc """
  The struct that holds a single players information
  """
  alias __MODULE__
  alias Game.PlayerType.HumanPlayer

  @type t :: %__MODULE__{}
  @typep player_type :: HumanPlayer | EasyComputerPlayer

  defstruct type: HumanPlayer, symbol: ""

  @spec create_player(player_type(), String.t()) :: Game.Player.t()
  def create_player(player_type, symbol) do
    %Player{type: player_type, symbol: symbol}
  end

  @spec get_move(Player.t(), map(), any) :: any
  def get_move(%Player{type: player_type, symbol: symbol}, board, communicator) do
    player_type.valid_input(board, symbol, communicator)
  end
end
