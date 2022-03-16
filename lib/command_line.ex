defmodule CommandLine do
  @behaviour DisplayBehaviour
  @moduledoc """
  The module that handles displaying a message to the Command Line
  """
  def display(message) do
    IO.write(message)
  end
end
