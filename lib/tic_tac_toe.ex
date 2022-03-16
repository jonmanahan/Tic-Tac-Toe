defmodule TicTacToe do
  @moduledoc """
  The module that handles the logic and communcation for a Command Line Interface
  Tic-Tac-Toe game
  """

  @welcome_message "Welcome to Tic-Tac-Toe"
  @display_empty_board "1 | 2 | 3"

  @spec start(any()) :: :ok
  def start(writer) do
    welcome = @welcome_message <> "\n\n" <> @display_empty_board <> "\n"

    writer.display(welcome)
  end
end
