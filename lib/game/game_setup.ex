defmodule Game.GameSetup do
  @moduledoc """
  The module that handles the player setup/selection logic for a Tic-Tac-Toe game
  """

  alias Game.Message
  alias Game.Validator
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Game.PlayerType.HardComputerPlayer

  @typep player :: HumanPlayer | EasyComputerPlayer | HardComputerPlayer

  @computer_types [%{type: EasyComputerPlayer, name: "Easy"}, %{type: HardComputerPlayer, name: "Unbeatable"}]
  @player_types [%{type: HumanPlayer, name: "Human"}, %{type: @computer_types, name: "Computer"}]
  @symbols ["X", "O"]

  @spec setup_players(any()) :: Players.t()
  def setup_players(interface) do
    [player_one, player_two] = Enum.map(@symbols, &(create_player(interface, &1)))

    Players.set_players(player_one, player_two)
  end

  @spec select_player_type(String.t(), list()) :: player
  defp select_player_type(player_selection, player_types) do
    {selection_number, _selection_decimal} = Integer.parse(player_selection)
    %{type: player_type} = Enum.at(player_types, selection_number - 1)
    player_type
  end

  @spec select_difficulty(player | list(), any()) :: player
  defp select_difficulty(HumanPlayer, _interface), do: HumanPlayer
  defp select_difficulty(computer_types, interface) do
    computer_type_status = computer_types
    |> interface.formatter.format_computer_difficulty_setup()
    |> interface.communicator.read_input()
    |> Validator.validate_setup(@computer_types)

    case computer_type_status do
      {:invalid, _invalid_setup_status} ->
        interface.communicator.display(Message.invalid_setup_input())
        select_difficulty(computer_types, interface)
      {:ok, player_type} -> player_type
    end
  end

  @spec create_player(any(), String.t()) :: Player.t()
  defp create_player(interface, player_symbol) do
    player_symbol
    |> interface.formatter.format_player_setup(@player_types, @symbols)
    |> interface.communicator.read_input()
    |> select_player_type(@player_types)
    |> select_difficulty(interface)
    |> Player.create_player(player_symbol)
  end
end
