defmodule CommandLine do
  @moduledoc """
  The module that handles displaying a message to the Command Line
  """

  @behaviour CommunicationBehaviour

  def display(message) do
    IO.write(message)
  end

  def read_input() do
    IO.gets("Please input desired placement: ")
  end
end
