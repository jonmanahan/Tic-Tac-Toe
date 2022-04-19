defmodule Communication.CommandLine do
  @moduledoc """
  The module that packages the command line and its formatter together
  """
  alias Communication.CommandLine.CommandLineCommunicator
  alias Communication.CommandLine.CommandLineFormatter

  @type t :: %__MODULE__{}

  defstruct communicator: CommandLineCommunicator, formatter: CommandLineFormatter
end
