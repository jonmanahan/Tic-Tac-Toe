defmodule WriterMock do
  @moduledoc """
  The module that mocks the Command Line display function,
  returning the message instead of displaying it to the Command Line
  """

  @behaviour DisplayBehaviour

  def display(message) do
    message
  end
end
