defmodule Game.PlayerType.HardComputerPlayer do
  @moduledoc """
  The module that handles a Hard (Unbeatable) Computer Players move via minimax
  """

  alias Game.PlayerType.PlayerBehaviour
  alias Game.Player
  alias Game.Board

  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(%Player{symbol: symbol}, board, communicator) do
    moves_with_scores = board
    |> Board.available_spaces()
    |> Map.new(fn {position, _empty_space} -> {position, minimax(Board.place_a_symbol(board, position, symbol), 0, symbol)} end)

    valid_move = get_best_move(Map.keys(moves_with_scores), Map.values(moves_with_scores), symbol)

    communicator.display("Player #{symbol}, please make desired move (Computer): #{valid_move}\n")

    {:ok, valid_move}
  end

  defp minimax(board, depth, symbol) do
    game_status = Board.game_status(board)

    if game_status != :in_progress do
      calculate_moves_score(depth, game_status, symbol)
    else
      case symbol do
        "X" -> Enum.min(get_scores_for_all_potential_moves(board, depth, "O"))
        "O" -> Enum.max(get_scores_for_all_potential_moves(board, depth, "X"))
      end
    end
  end

  defp get_best_move(moves, scores, symbol) do
    case symbol do
      "X" -> Enum.at(moves, Enum.find_index(scores, fn score -> score == Enum.max(scores) end))
      "O" -> Enum.at(moves, Enum.find_index(scores, fn score -> score == Enum.min(scores) end))
    end
  end

  defp calculate_moves_score(_depth, :tied, _symbol), do: 0
  defp calculate_moves_score(depth, :won, "X"), do: 10 - depth
  defp calculate_moves_score(depth, :won, "O"), do: -10 + depth

  defp get_scores_for_all_potential_moves(board, depth, symbol) do
    board
    |> Board.available_spaces()
    |> Map.keys()
    |> Enum.map(fn position -> minimax(Board.place_a_symbol(board, position, symbol), depth + 1, symbol) end)
  end
end
