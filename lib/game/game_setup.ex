defmodule Game.GameSetup do
  @moduledoc """
  The module that handles the player setup/selection logic for a Tic-Tac-Toe game
  """

  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer

  @typep player_type :: HumanPlayer | EasyComputerPlayer

  @spec setup_players(any()) :: Players.t()
  def setup_players(communicator) do
    player_one = create_player(communicator, 1, "X")
    player_two = create_player(communicator, 2, "O")

    Players.set_players(player_one, player_two)
  end

  @spec select_player_type(String.t()) :: player_type
  defp select_player_type(player_selection) do
    case player_selection do
      "1" -> HumanPlayer
      "2" -> EasyComputerPlayer
    end
  end

  @spec create_player(any(), non_neg_integer(), String.t()) :: Player.t()
  defp create_player(communicator, player_number, player_symbol) do
    "Please select Player #{player_number} (#{player_symbol}) => 1 - Human, 2 - Computer: "
      |> communicator.read_input()
      |> String.trim()
      |> select_player_type()
      |> Player.create_player(player_symbol)
  end
end
