defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any()) :: :ok
  def start(communicator, unformatted_board \\ Board.setup_initial_board()) do
    welcome = @welcome_message <> "\n" <> Board.format_board_to_display(unformatted_board)
    communicator.display(welcome)

    player_move = String.trim(communicator.read_input())
    unformatted_board = Board.update_board(unformatted_board, player_move, "X")
    communicator.display(Board.format_board_to_display(unformatted_board))
  end
end
