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
    case Validator.validate(board, player_input) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, "X")
        communicator.display(communicator_formatter.format_board(board))

        board
        |> Message.game_status()
        |> communicator.display()
      {:invalid, invalid_input_status} ->
        invalid_input_status
        |> Message.invalid_input()
        |> communicator.display()

        start(communicator, communicator_formatter, board)
    end
  end
end
