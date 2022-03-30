defmodule Board do
  @moduledoc """
  The module that handles the Board logic for a Tic-Tac-Toe game
  """

  @spec setup_initial_board(non_neg_integer()) :: map()
  def setup_initial_board(board_dimensions \\ 3) do
    Map.new(1..board_dimensions * board_dimensions, fn position -> {position, :empty} end)
  end

  @spec place_a_symbol(map(), non_neg_integer(), String.t()) :: map()
  def place_a_symbol(board, player_move, symbol) do
    Map.replace(board, player_move, symbol)
  end

  @spec game_status(map()) :: atom()
  def game_status(board) do
    cond do
      has_player_won?(board) -> :won
      is_board_full?(board) -> :tied
      true -> :in_progress
    end
  end

  @spec has_player_won?(map()) :: boolean()
  defp has_player_won?(board) do
    Enum.any?([get_all_rows_status(board), get_all_columns_status(board), get_both_diagonals_status(board)])
  end

  @spec is_board_full?(map) :: boolean
  defp is_board_full?(board) do
    !Enum.member?(Map.values(board), :empty)
  end

  @spec get_board_dimensions(map()) :: integer()
  def get_board_dimensions(board) do
    trunc(:math.sqrt(Enum.count(board)))
  end

  @spec get_all_rows_status(map()) :: boolean()
  defp get_all_rows_status(board) do
    board_dimensions = get_board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec get_all_columns_status(map()) :: boolean()
  defp get_all_columns_status(board) do
    board_dimensions = get_board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.zip()
    |> Enum.map(fn columns -> Enum.uniq(Tuple.to_list(columns)) end)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec get_both_diagonals_status(map()) :: boolean()
  defp get_both_diagonals_status(board) do
    board_dimensions = get_board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> get_diagonal_values(board_dimensions)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec get_diagonal_values(list(), integer()) :: list()
  defp get_diagonal_values(board, board_dimensions) do
    forward_diagonal = for diagonal_index <- 0..board_dimensions - 1, do: Enum.at(Enum.at(board, diagonal_index), diagonal_index)
    backward_diagonal = for diagonal_index <- 0..board_dimensions - 1, do: Enum.at(Enum.at(board, diagonal_index), (board_dimensions - 1) - diagonal_index)
    [forward_diagonal, backward_diagonal]
  end

  @spec is_winning_vector?(list()) :: boolean()
  defp is_winning_vector?(symbols_in_vector) do
    Enum.count(symbols_in_vector) == 1 && !Enum.member?(symbols_in_vector, :empty)
  end
end
