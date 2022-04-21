defmodule Game.PlayerType.HardComputerPlayer do
  @moduledoc """
  The module that handles a Hard (Unbeatable) Computer Players move via minimax
  """

  alias Game.PlayerType.PlayerBehaviour
  alias Game.Board

  @behaviour PlayerBehaviour

  @impl PlayerBehaviour
  def valid_input(board, symbol, communicator) do
    moves_with_scores = board
    |> Board.available_spaces()
    |> Map.new(fn {position, _empty_space} -> {position, minimax(Board.place_a_symbol(board, position, symbol), 0, symbol)} end)

    positions = Map.keys(moves_with_scores)
    scores = Map.values(moves_with_scores)

    valid_move = if symbol == "X" do
      Enum.at(positions, Enum.find_index(scores, fn score -> score == Enum.max(scores) end))
    else
      Enum.at(positions, Enum.find_index(scores, fn score -> score == Enum.min(scores) end))
    end

    communicator.display("Player #{symbol}, please make desired move (Computer): #{valid_move}\n")

    {:ok, valid_move}
  end

  defp minimax(board, depth, symbol) do
    game_status = Board.game_status(board)

    if game_status != :in_progress do
      calculate_initial_move_score(depth, game_status, symbol)
    else
      if symbol == "X" do
        symbol = "O"

        scores = board
        |> Board.available_spaces()
        |> Map.keys()
        |> Enum.map(fn position -> minimax(Board.place_a_symbol(board, position, symbol), depth + 1, symbol) end)

        Enum.min(scores)
      else
        symbol = "X"

        scores = board
        |> Board.available_spaces()
        |> Map.keys()
        |> Enum.map(fn position -> minimax(Board.place_a_symbol(board, position, symbol), depth + 1, symbol) end)

        Enum.max(scores)
      end
    end
  end

  defp calculate_initial_move_score(depth, game_status, symbol) do
    if game_status == :won do
      case symbol do
        "X" -> 10 - depth
        "O" -> -10 + depth
      end
    else
      0
    end
  end
end
