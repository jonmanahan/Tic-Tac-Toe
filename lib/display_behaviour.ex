defmodule DisplayBehaviour do
  @moduledoc """
  The module that defines a generic display function
  """
  @callback display(message :: String.t()) :: :ok | String.t()
end
