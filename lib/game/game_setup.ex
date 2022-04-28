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
  def setup_players(user_interface) do
    [player_one, player_two] = Enum.map(@symbols, &(create_player(user_interface, &1)))

    Players.set_players(player_one, player_two)
  end

  @spec select_player_type(String.t(), any()) :: player
  defp select_player_type(player_symbol, user_interface) do
    player_symbol
    |> user_interface.formatter.format_player_setup(@player_types, @symbols)
    |> user_interface.communicator.read_input()
    |> Validator.validate_setup(@player_types)
    |> get_valid_player_type(player_symbol, user_interface)
  end

  @spec get_valid_player_type({:ok, list() | player} | {:invalid, atom()}, String.t(), any()) :: list() | player
  defp get_valid_player_type({:ok, player_type}, _player_symbol, _user_interface), do: player_type
  defp get_valid_player_type({:invalid, _reason}, player_symbol, user_interface) do
    user_interface.communicator.display(Message.invalid_setup_input())
    select_player_type(player_symbol, user_interface)
  end

  @spec select_difficulty(player | list(), any()) :: player
  defp select_difficulty(HumanPlayer, _user_interface), do: HumanPlayer
  defp select_difficulty(computer_types, user_interface) do
    computer_types
    |> user_interface.formatter.format_computer_difficulty_setup()
    |> user_interface.communicator.read_input()
    |> Validator.validate_setup(@computer_types)
    |> get_valid_difficulty(user_interface)
  end

  @spec get_valid_difficulty({:ok, player} | {:invalid, atom()}, any()) :: player
  defp get_valid_difficulty({:ok, difficulty}, _user_interface), do: difficulty
  defp get_valid_difficulty({:invalid, _reason}, user_interface) do
    user_interface.communicator.display(Message.invalid_setup_input())
    select_difficulty(@computer_types, user_interface)
  end

  @spec create_player(any(), String.t()) :: Player.t()
  defp create_player(user_interface, player_symbol) do
    player_symbol
    |> select_player_type(user_interface)
    |> select_difficulty(user_interface)
    |> Player.create_player(player_symbol)
  end
end
