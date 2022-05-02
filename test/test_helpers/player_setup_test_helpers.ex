defmodule PlayerSetupTestHelper do
  @moduledoc """
  The module that descriptively defines the player selection and difficulty selection inputs
  """

  defstruct [
    human_player: "1",
    computer_player: "2",
    easy_mode_computer: "1",
    hard_mode_computer: "2",
    invalid_input: "5"
  ]
end
