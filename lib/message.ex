defmodule Message do
  @moduledoc """
  The module that handles the messages that correspond to a given status for a Tic-Tac-Toe game
  """

  @spec game_status(map(), String.t()) :: String.t()
  def game_status(board, player_symbol) do
    case Board.game_status(board) do
      :won -> "Player #{player_symbol} has Won!\n"
      :tied -> "No player has won, tie!\n"
      _ -> ""
    end
  end

  @spec invalid_input(atom()) :: String.t()
  def invalid_input(invalid_input_status) do
    case invalid_input_status do
      :non_numerical -> "Invalid input, please input a number between 1 and 9\n"
      :out_of_bounds -> "Invalid input, number out of bounds\n"
      :space_taken -> "Invalid input, position has already been taken\n"
    end
  end
end
