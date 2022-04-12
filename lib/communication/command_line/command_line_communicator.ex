defmodule Communication.CommandLine.CommandLineCommunicator do
  @moduledoc """
  The module that handles displaying a message to the Command Line
  """

  alias Communication.CommunicationBehaviour
  @behaviour CommunicationBehaviour

  def display(message) do
    IO.write(message)
  end

  def read_input() do
    IO.gets("please make desired move: ")
  end
end
