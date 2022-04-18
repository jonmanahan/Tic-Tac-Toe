defmodule Communication.CommunicationBehaviour do
  @moduledoc """
  The module that defines a generic communicators functions
  """
  @callback display(message :: String.t()) :: :ok | String.t()
  @callback read_input(prompt :: String.t()) :: String.t()
end
