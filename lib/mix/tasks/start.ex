defmodule Mix.Tasks.Start do
  use Mix.Task
  @moduledoc """
  Documentation for `MixTasksStart`.
  """

  def run(_) do
    TicTacToe.start(CommandLine)
  end
end
