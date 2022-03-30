defmodule Validator do
  @moduledoc """
  The module that handles checking to see if the user input is numerical for a Tic-Tac-Toe game
  """

  @type message :: :non_numerical

  @spec validate(String.t() | integer()) :: {atom(), non_neg_integer() | message}
  def validate(user_input) when is_binary(user_input) do
    case Integer.parse(user_input) do
      {player_move, _} -> {:ok, player_move}
      :error -> {:error, :non_numerical}
    end
  end

  def validate(user_input) do
    {:ok, user_input}
  end
end
