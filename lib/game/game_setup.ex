defmodule Game.GameSetup do
  @moduledoc """
  The module that handles the player setup/selection logic for a Tic-Tac-Toe game
  """

  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer

  @typep player :: HumanPlayer | EasyComputerPlayer

  @player_types [%{type: HumanPlayer, name: "Human"}, %{type: EasyComputerPlayer, name: "Computer"}]
  @symbols ["X", "O"]

  @spec setup_players(any()) :: Players.t()
  def setup_players(interface) do
    [player_one, player_two] = Enum.map(@symbols, &(create_player(interface, &1)))

    Players.set_players(player_one, player_two)
  end

  @spec select_player_type(String.t()) :: player
  defp select_player_type(player_selection) do
    {selection_number, _selection_decimal} = Integer.parse(player_selection)
    %{type: player_type} = Enum.at(@player_types, selection_number - 1)
    player_type
  end

  @spec create_player(any(), String.t()) :: Player.t()
  defp create_player(interface, player_symbol) do
    player_symbol
    |> interface.formatter.format_player_setup(@player_types, @symbols)
    |> interface.communicator.read_input()
    |> String.trim()
    |> select_player_type()
    |> Player.create_player(player_symbol)
  end
end
