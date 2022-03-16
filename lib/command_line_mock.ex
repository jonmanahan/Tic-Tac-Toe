defmodule CommandLineMock do
  @behaviour DisplayBehaviour

  def display(message) do
    message
  end
end
