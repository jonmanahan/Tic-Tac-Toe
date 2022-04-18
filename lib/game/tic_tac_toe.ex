defmodule Game.TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  alias Game.Board
  alias Game.Message
  alias Game.Player
  alias Game.GameSetup

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any(), any()) :: nil
  def start(communicator, communicator_formatter) do
    board = Board.setup_initial_board()
    players = GameSetup.setup_players(communicator)

    welcome = @welcome_message <> "\n" <> communicator_formatter.format_board(board)
    communicator.display(welcome)

    start(communicator, communicator_formatter, board, players)
  end

  def start(communicator, communicator_formatter, board, players) do
    %Player{symbol: current_symbol, type: player_type} = Map.get(players, Board.calculate_turn(board))
    communicator.display("Player #{current_symbol}, ")
    case player_type.valid_input(board, communicator) do
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
