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

  @spec setup_players(any()) :: Players.t()
  def setup_players(user_interface) do
    symbols = [{1, "X"}, {2, "O"}]
    [player_one, player_two] = Enum.map(symbols, &(create_player(user_interface, &1)))

    Players.set_players(player_one, player_two)
  end

  @spec select_player_type(player | list(), String.t(), any()) :: player | list()
  defp select_player_type(player_types, prompt, user_interface) do
    selection = player_types
    |> user_interface.formatter.format_setup_prompt(prompt)
    |> user_interface.communicator.read_input()
    |> Integer.parse()
    |> get_type_selection(player_types)

    case selection do
      nil -> select_player_type(player_types, Message.invalid_setup_input(), user_interface)
      %{type: type} -> type
    end
  end

  @spec get_type_selection(:error | {integer(), String.t()}, list() | player) :: list() | Player.t() | nil
  defp get_type_selection(:error, _), do: nil
  defp get_type_selection({selection, _}, types) do
    if selection < 1 do
      nil
    else
      Enum.at(types, selection - 1)
    end
  end

  @spec select_difficulty(player | list(), String.t(), any()) :: player
  defp select_difficulty(HumanPlayer, _prompt, _user_interface), do: HumanPlayer
  defp select_difficulty(computer_types, prompt, user_interface) do
    computer_types
    |> user_interface.formatter.format_setup_prompt(prompt)
    |> user_interface.communicator.read_input()
    |> Validator.validate_setup(@computer_types)
    |> get_valid_difficulty(prompt, user_interface)
  end

  @spec get_valid_difficulty({:ok, player} | {:invalid, atom()}, String.t(), any()) :: player
  defp get_valid_difficulty({:ok, difficulty}, _prompt, _user_interface), do: difficulty
  defp get_valid_difficulty({:invalid, _reason}, prompt, user_interface) do
    user_interface.communicator.display(Message.invalid_setup_input())
    select_difficulty(@computer_types, prompt, user_interface)
  end

  @spec create_player(any(), tuple()) :: Player.t()
  defp create_player(user_interface, {player_number, player_symbol}) do
    player_select_prompt = "Please select Player #{player_number} (#{player_symbol}) => "
    difficulty_select_prompt = "Please select Difficulty => "
    @player_types
    |> select_player_type(player_select_prompt, user_interface)
    |> select_difficulty(difficulty_select_prompt, user_interface)
    |> Player.create_player(player_symbol)
  end
end
