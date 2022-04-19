defmodule Game.TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  alias Game.Board
  alias Game.Message
  alias Game.Player
  alias Game.GameSetup

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any()) :: nil
  def start(interface) do
    board = Board.setup_initial_board()
    players = GameSetup.setup_players(interface)

    welcome = @welcome_message <> "\n" <> interface.formatter.format_board(board)
    interface.communicator.display(welcome)

    start(interface, board, players)
  end

  def start(interface, board, players) do
    %Player{symbol: current_symbol, type: player_type} = Map.get(players, Board.calculate_turn(board))
    interface.communicator.display("Player #{current_symbol}, ")
    case player_type.valid_input(board, interface.communicator) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, current_symbol)
        interface.communicator.display(interface.formatter.format_board(board))

        board
        |> Message.game_status(current_symbol)
        |> interface.communicator.display()
        if Board.game_status(board) == :in_progress, do: start(interface, board, players)
      {:invalid, invalid_input_status} ->
        invalid_input_status
        |> Message.invalid_input()
        |> interface.communicator.display()

        start(interface, board, players)
    end
  end
end
