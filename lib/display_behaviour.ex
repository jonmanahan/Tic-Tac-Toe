defmodule DisplayBehaviour do
  @moduledoc """
  The module that defines a generic display function
  """
  @callback display(arg :: any) :: any
end
