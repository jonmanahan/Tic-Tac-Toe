defmodule Validator do
  @moduledoc """
  The module that handles checking to see if the user input is numerical for a Tic-Tac-Toe game
  """

  @type message :: :non_numerical | :out_of_bounds | :space_taken

  @spec validate(map(), String.t() | integer()) :: {atom(), non_neg_integer() | message}
  def validate(board, user_input) when is_binary(user_input) do
    case Integer.parse(user_input) do
      {player_move, _} -> validate(board, player_move)
      :error -> {:invalid, :non_numerical}
    end
  end

  def validate(board, player_move) do
    case Board.move_status(board, player_move) do
      :out_of_bounds -> {:invalid, :out_of_bounds}
      :space_taken -> {:invalid, :space_taken}
      :valid -> {:ok, player_move}
    end
  end
end
