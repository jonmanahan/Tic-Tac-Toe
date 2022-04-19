defmodule Communication.CommandLine.CommandLineFormatter do
  @moduledoc """
  The module that handles formatting a board to be displayed to the Command Line
  """

  alias Game.Board

  @spec format_board(map()) :: String.t()
  def format_board(board) do
    board_dimensions = Board.board_dimensions(board)
    board
    |> Enum.map(&format_position/1)
    |> Map.new()
    |> Map.values()
    |> Enum.chunk_every(board_dimensions)
    |> Enum.map_intersperse(build_separator(board_dimensions), &build_row/1)
    |> List.insert_at(0, "\n")
    |> List.insert_at(-1, "\n\n")
    |> Enum.join()
  end

  @spec format_player_setup(String.t(), list(), list()) :: String.t()
  def format_player_setup(player_symbol, player_types, symbols) do
    player_number = get_player_number_by_symbol(player_symbol, symbols)

    player_types
    |> Enum.with_index(fn player, index -> {"#{index + 1}", player} end)
    |> Enum.map_intersperse(", ", fn {selection_number, %{name: player_name}} -> "#{selection_number} - #{player_name}" end)
    |> List.insert_at(0, "Please select Player #{player_number} (#{player_symbol}) => ")
    |> List.insert_at(-1, ": ")
    |> Enum.join()
  end

  @spec get_player_number_by_symbol(String.t(), list()) :: non_neg_integer()
  defp get_player_number_by_symbol(player_symbol, symbols) do
    Enum.find_index(symbols, fn symbol -> symbol == player_symbol end) + 1
  end

  defp format_position({board_position, :empty}) do
    {board_position, "#{board_position}"}
  end

  defp format_position(position), do: position

  @spec build_row(list()) :: String.t()
  defp build_row(row) do
    Enum.join(row, " | ")
  end

  @spec build_separator(non_neg_integer()) :: String.t()
  defp build_separator(board_dimensions) do
    number_of_center_columns = board_dimensions - 2
    "\n--|" <> String.duplicate("---|", number_of_center_columns) <> "--\n"
  end
end
