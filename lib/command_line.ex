defmodule CommandLine do
  @moduledoc """
  The module that handles displaying a message to the Command Line
  """

  @behaviour DisplayBehaviour

  def display(message) do
    IO.write(message)
  end
end
