defmodule Mix.Tasks.Start do
  use Mix.Task
  @moduledoc """
  Documentation for `MixTasksStart`.
  """

  alias Game.TicTacToe
  alias Communication.CommandLine.CommandLineFormatter
  alias Communication.CommandLine.CommandLineCommunicator

  def run(_) do
    TicTacToe.start(CommandLineCommunicator, CommandLineFormatter)
  end
end
