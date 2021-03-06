defmodule Communication.CommandLine.CommandLineCommunicator do
  @moduledoc """
  The module that handles displaying a message to and reading from the Command Line
  """

  alias Communication.CommunicationBehaviour
  @behaviour CommunicationBehaviour

  def display(message) do
    IO.write(message)
  end

  def read_input(prompt) do
    IO.gets(prompt)
  end
end
