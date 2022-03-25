defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any(), any()) :: :ok
  def start(communicator, communicator_formatter, board \\ Board.setup_initial_board()) do
    welcome = @welcome_message <> "\n" <> communicator_formatter.format_board(board)
    communicator.display(welcome)

    player_move = String.trim(communicator.read_input())
    board = Board.place_a_symbol(board, player_move, "X")
    communicator.display(communicator_formatter.format_board(board))

    if Board.has_player_won?(board) do
      communicator.display("Player X has Won!")
    end
  end
end
