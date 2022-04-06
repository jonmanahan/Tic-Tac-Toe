defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any(), any()) :: nil
  def start(communicator, communicator_formatter, board \\ Board.setup_initial_board()) do
    welcome = @welcome_message <> "\n" <> communicator_formatter.format_board(board)
    communicator.display(welcome)

    play_turn(communicator, communicator_formatter, board)
  end

  @spec play_turn(any(), any(), map()) :: nil
  defp play_turn(communicator, communicator_formatter, board) do
    player_symbol = Board.calculate_turn(board)
    communicator.display("Player #{player_symbol}, ")
    player_input = String.trim(communicator.read_input())
    case Validator.validate(board, player_input) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, player_symbol)
        communicator.display(communicator_formatter.format_board(board))

        board
        |> Message.game_status(player_symbol)
        |> communicator.display()
        if Board.game_status(board) == :in_progress, do: play_turn(communicator, communicator_formatter, board)
      {:invalid, invalid_input_status} ->
        invalid_input_status
        |> Message.invalid_input()
        |> communicator.display()

        play_turn(communicator, communicator_formatter, board)
    end
  end
end
