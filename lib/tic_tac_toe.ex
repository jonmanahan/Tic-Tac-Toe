defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communication for a Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"
  @display_empty_board """
  1 | 2 | 3
  --|---|--
  4 | 5 | 6
  --|---|--
  7 | 8 | 9
  """

  @spec start(any()) :: :ok
  def start(communicator) do
    welcome = @welcome_message <> "\n\n" <> @display_empty_board <> "\n"

    communicator.display(welcome)
    communicator.read_input()
  end
end
