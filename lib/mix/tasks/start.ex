defmodule Mix.Tasks.Start do
  use Mix.Task
  @moduledoc """
  Documentation for `MixTasksStart`.
  """

  alias Game.TicTacToe
  alias Game.Player.HumanPlayer
  alias Communication.CommandLine.CommandLineFormatter
  alias Communication.CommandLine.CommandLineCommunicator

  @human_players %{"X" => HumanPlayer, "O" => HumanPlayer}

  def run(_) do
    TicTacToe.start(CommandLineCommunicator, CommandLineFormatter, @human_players)
  end
end
