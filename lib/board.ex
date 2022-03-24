defmodule Board do
  @moduledoc """
  The module that handles the Board logic for a Tic-Tac-Toe game
  """

  @spec setup_initial_board(non_neg_integer()) :: map()
  def setup_initial_board(board_dimensions \\ 3) do
    Map.new(1..board_dimensions * board_dimensions, fn position -> {position, "#{position}"} end)
  end

  @spec place_a_symbol(map(), String.t(), String.t()) :: map()
  def place_a_symbol(board, player_move, symbol) do
    Map.replace(board, String.to_integer(player_move), symbol)
  end
end
