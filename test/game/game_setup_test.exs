defmodule GameSetupTest do
  use ExUnit.Case

  alias Game.GameSetup
  alias Game.Player
  alias Game.Players
  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Game.PlayerType.HardComputerPlayer
  alias Communication.CommandLine

  @mock_command_line %CommandLine{communicator: CommunicatorMock}
  @input %TestHelper{}

  describe "setup_players/1" do
    test "returns players containing a Human player 1 and Human player 2 with their associated symbols" do
      user_inputs = [@input.human_player, @input.human_player]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HumanPlayer, symbol: "X"},
          player_two: %Player{type: HumanPlayer, symbol: "O"}
        }
    end

    test "returns players containing a Human player 1 and an Easy Computer player 2 with their associated symbols" do
      user_inputs = [@input.human_player, @input.computer_player, @input.easy_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HumanPlayer, symbol: "X"},
          player_two: %Player{type: EasyComputerPlayer, symbol: "O"}
        }
    end

    test "returns players containing a Human player 1 and an Unbeatable Computer player 2 with their associated symbols" do
      user_inputs = [@input.human_player, @input.computer_player, @input.hard_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HumanPlayer, symbol: "X"},
          player_two: %Player{type: HardComputerPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Easy Computer player 1 and Human player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.easy_mode_computer, @input.human_player]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: EasyComputerPlayer, symbol: "X"},
          player_two: %Player{type: HumanPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Unbeatable Computer player 1 and Human player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.hard_mode_computer, @input.human_player]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HardComputerPlayer, symbol: "X"},
          player_two: %Player{type: HumanPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Easy Computer player 1 and an Easy Computer player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.easy_mode_computer, @input.computer_player, @input.easy_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: EasyComputerPlayer, symbol: "X"},
          player_two: %Player{type: EasyComputerPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Easy Computer player 1 and an Unbeatable Computer player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.easy_mode_computer, @input.computer_player, @input.hard_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: EasyComputerPlayer, symbol: "X"},
          player_two: %Player{type: HardComputerPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Unbeatable Computer player 1 and an Easy Computer player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.hard_mode_computer, @input.computer_player, @input.easy_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HardComputerPlayer, symbol: "X"},
          player_two: %Player{type: EasyComputerPlayer, symbol: "O"}
        }
    end

    test "returns players containing an Unbeatable Computer player 1 and an Unbeatable Computer player 2 with their associated symbols" do
      user_inputs = [@input.computer_player, @input.hard_mode_computer, @input.computer_player, @input.hard_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      assert GameSetup.setup_players(@mock_command_line) ==
        %Players{
          player_one: %Player{type: HardComputerPlayer, symbol: "X"},
          player_two: %Player{type: HardComputerPlayer, symbol: "O"}
        }
    end

    test "displays invalid setup validation message via invalid input for difficulty selection, then returns players containing selected players and associated symbols" do
      user_inputs = [@input.computer_player, @input.invalid_input, @input.hard_mode_computer, @input.computer_player, @input.hard_mode_computer]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      players = GameSetup.setup_players(@mock_command_line)

      assert CommunicatorMock.get_message_history() =~
        "Invalid selection, please enter 1 or 2\n"

      assert players ==
        %Players{
          player_one: %Player{type: HardComputerPlayer, symbol: "X"},
          player_two: %Player{type: HardComputerPlayer, symbol: "O"}
        }
    end

    test "displays invalid setup validation message via invalid input for player selection, then returns players containing selected players and associated symbols" do
      user_inputs = [@input.invalid_input, @input.human_player, @input.human_player]
      start_supervised!({@mock_command_line.communicator, user_inputs})

      players = GameSetup.setup_players(@mock_command_line)

      assert CommunicatorMock.get_message_history() =~
        "Invalid selection, please enter 1 or 2\n"

      assert players ==
        %Players{
          player_one: %Player{type: HumanPlayer, symbol: "X"},
          player_two: %Player{type: HumanPlayer, symbol: "O"}
        }
    end
  end
end
