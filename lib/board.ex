defmodule Board do
  @moduledoc """
  The module that handles the Board logic for a Tic-Tac-Toe game
  """

  @spec setup_initial_board(non_neg_integer()) :: map()
  def setup_initial_board(board_dimensions \\ 3) do
    Map.new(1..board_dimensions * board_dimensions, fn position -> {position, "#{position}"} end)
  end

  @spec update_board(map(), String.t(), String.t()) :: map()
  def update_board(unformatted_board, player_move, symbol) do
    Map.replace(unformatted_board, String.to_integer(player_move), symbol)
  end

  @spec format_board_to_display(map()) :: String.t()
  def format_board_to_display(unformatted_board) do
    board_dimensions = trunc(:math.sqrt(Enum.count(unformatted_board)))
    unformatted_board
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.map_intersperse(build_separator(board_dimensions), &build_row/1)
    |> List.insert_at(0, "\n")
    |> List.insert_at(-1, "\n\n")
    |> Enum.join()
  end

  @spec build_row(List.t()) :: String.t()
  defp build_row(row) do
    Enum.join(row, " | ")
  end

  @spec build_separator(non_neg_integer()) :: String.t()
  defp build_separator(board_dimensions) do
    number_of_center_columns = board_dimensions - 2
    "\n--|" <> String.duplicate("---|", number_of_center_columns) <> "--\n"
  end
end
