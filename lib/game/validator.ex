defmodule Game.Validator do
  @moduledoc """
  The module that handles checking to see if the user input is numerical for a Tic-Tac-Toe game
  """

  alias Game.Board

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

  @spec validate_setup(String.t() | integer, list()) :: {:invalid, :invalid_setup} | {:ok, any}
  def validate_setup(player_selection, player_types) when is_binary(player_selection) do
    case Integer.parse(player_selection) do
      {selection_number, _selection_decimal} -> validate_setup(selection_number, player_types)
      :error -> {:invalid, :invalid_setup}
    end
  end

  def validate_setup(selection_number, player_types) do
    case Enum.at(player_types, selection_number - 1) do
      %{type: player_type} -> {:ok, player_type}
      nil -> {:invalid, :invalid_setup}
    end
  end
end
