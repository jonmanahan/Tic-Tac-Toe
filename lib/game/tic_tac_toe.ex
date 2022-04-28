defmodule Game.TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  alias Game.Board
  alias Game.Message
  alias Game.Player
  alias Game.Players
  alias Game.GameSetup

  @welcome_message "Welcome to Tic-Tac-Toe"

  @spec start(any()) :: nil
  def start(user_interface) do
    board = Board.setup_initial_board()
    players = GameSetup.setup_players(user_interface)

    welcome = @welcome_message <> "\n" <> user_interface.formatter.format_board(board)
    user_interface.communicator.display(welcome)

    start(user_interface, board, players)
  end

  def start(user_interface, board, players) do
    player = Players.get_player(players, Board.calculate_turn(board))
    case Player.get_move(player, board, user_interface.communicator) do
      {:ok, player_move} ->
        board = Board.place_a_symbol(board, player_move, player.symbol)
        user_interface.communicator.display(user_interface.formatter.format_board(board))

        board
        |> Message.game_status(player.symbol)
        |> user_interface.communicator.display()
        if Board.game_status(board) == :in_progress, do: start(user_interface, board, players)
      {:invalid, invalid_input_status} ->
        invalid_input_status
        |> Message.invalid_input()
        |> user_interface.communicator.display()

        start(user_interface, board, players)
    end
  end
end
