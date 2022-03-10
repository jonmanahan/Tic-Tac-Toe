defmodule TicTacToe do
  @moduledoc """
  Documentation for `TicTacToe`.
  """

  @spec welcome_message :: :ok
  def welcome_message do
    CommandLine.display("Welcome to Tic-Tac-Toe")
  end
end
