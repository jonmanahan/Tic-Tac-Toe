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
    |> format_player_selections_with_numbers()
    |> List.insert_at(0, "Please select Player #{player_number} (#{player_symbol}) => ")
    |> Enum.join()
  end

  def format_computer_difficulty_setup(computer_difficulties) do
    computer_difficulties
    |> format_player_selections_with_numbers()
    |> List.insert_at(0, "Please select Difficulty => ")
    |> Enum.join()
  end

  defp format_player_selections_with_numbers(selections) do
    selections
    |> Enum.with_index(fn selection, index -> {"#{index + 1}", selection} end)
    |> Enum.map_intersperse(", ", fn {selection_number, %{name: selection_name}} -> "#{selection_number} - #{selection_name}" end)
    |> List.insert_at(-1, ": ")
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
