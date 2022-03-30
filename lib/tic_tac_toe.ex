defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any(), any()) :: :ok
  def start(communicator, communicator_formatter, board \\ Board.setup_initial_board()) do
    welcome = @welcome_message <> "\n" <> communicator_formatter.format_board(board)
    communicator.display(welcome)

    player_input = String.trim(communicator.read_input())
    case Validator.validate(player_input) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, "X")
        communicator.display(communicator_formatter.format_board(board))

        board
        |> get_game_status_message()
        |> communicator.display()
      {:error, _} ->
        communicator.display("Invalid input, please input a number between 1 and 9\n")
        start(communicator, communicator_formatter, board)
    end
  end

  @spec get_game_status_message(map()) :: String.t()
  defp get_game_status_message(board) do
    case Board.game_status(board) do
      :won -> "Player X has Won!\n"
      :tied -> "No player has won, tie!\n"
      _ -> ""
    end
  end
end
