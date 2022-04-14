defmodule Game.TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  alias Game.Board
  alias Game.Message
  #alias Game.Player.HumanPlayer

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any(), any(), map()) :: nil
  def start(communicator, communicator_formatter, players) do
    board = Board.setup_initial_board()
    welcome = @welcome_message <> "\n" <> communicator_formatter.format_board(board)
    communicator.display(welcome)

    start(communicator, communicator_formatter, board, players)
  end

  def start(communicator, communicator_formatter, board, players) do
    current_symbol = Board.calculate_turn(board)
    current_player = Map.fetch!(players, current_symbol)
    communicator.display("Player #{current_symbol}, ")
    case current_player.valid_input(board, communicator) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, current_symbol)
        communicator.display(communicator_formatter.format_board(board))

        board
        |> Message.game_status(current_symbol)
        |> communicator.display()
        if Board.game_status(board) == :in_progress, do: start(communicator, communicator_formatter, board, players)
      {:invalid, invalid_input_status} ->
        invalid_input_status
        |> Message.invalid_input()
        |> communicator.display()

        start(communicator, communicator_formatter, board, players)
    end
  end
end
