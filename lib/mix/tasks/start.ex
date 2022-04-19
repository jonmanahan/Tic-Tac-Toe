defmodule Mix.Tasks.Start do
  use Mix.Task
  @moduledoc """
  Documentation for `MixTasksStart`.
  """

  alias Game.TicTacToe
  alias Communication.CommandLine

  def run(_) do
    TicTacToe.start(%CommandLine{})
  end
end
