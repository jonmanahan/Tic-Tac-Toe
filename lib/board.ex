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

  @spec move_status(map(), integer()) :: atom()
  def move_status(board, player_move) do
    cond do
      is_out_of_bounds?(board, player_move) -> :out_of_bounds
      is_space_taken?(board, player_move) -> :space_taken
      true -> :valid
    end
  end

  @spec is_space_taken?(map(), integer()) :: boolean()
  defp is_space_taken?(board, player_move) do
    Map.fetch!(board, player_move) != :empty
  end

  @spec is_out_of_bounds?(map(), integer()) :: boolean()
  defp is_out_of_bounds?(board, player_move) do
    player_move not in 1..Enum.count(board)
  end

  @spec has_player_won?(map()) :: boolean()
  defp has_player_won?(board) do
    Enum.any?([win_by_rows?(board), win_by_columns?(board), win_by_diagonals?(board)])
  end

  @spec is_board_full?(map) :: boolean
  defp is_board_full?(board) do
    !Enum.member?(Map.values(board), :empty)
  end

  @spec board_dimensions(map()) :: integer()
  def board_dimensions(board) do
    trunc(:math.sqrt(Enum.count(board)))
  end

  @spec win_by_rows?(map()) :: boolean()
  defp win_by_rows?(board) do
    board_dimensions = board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec win_by_columns?(map()) :: boolean()
  defp win_by_columns?(board) do
    board_dimensions = board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.zip()
    |> Enum.map(fn columns -> Enum.uniq(Tuple.to_list(columns)) end)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec win_by_diagonals?(map()) :: boolean()
  defp win_by_diagonals?(board) do
    board_dimensions = board_dimensions(board)
    board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> diagonal_values(board_dimensions)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.any?(&is_winning_vector?/1)
  end

  @spec diagonal_values(list(), integer()) :: list()
  defp diagonal_values(board, board_dimensions) do
    forward_diagonal = for diagonal_index <- 0..board_dimensions - 1, do: Enum.at(Enum.at(board, diagonal_index), diagonal_index)
    backward_diagonal = for diagonal_index <- 0..board_dimensions - 1, do: Enum.at(Enum.at(board, diagonal_index), (board_dimensions - 1) - diagonal_index)
    [forward_diagonal, backward_diagonal]
  end

  @spec is_winning_vector?(list()) :: boolean()
  defp is_winning_vector?(symbols_in_vector) do
    Enum.count(symbols_in_vector) == 1 && !Enum.member?(symbols_in_vector, :empty)
  end
end
