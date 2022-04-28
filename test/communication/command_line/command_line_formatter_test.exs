defmodule CommandLineFormatterTest do
  use ExUnit.Case

  alias Game.PlayerType.HumanPlayer
  alias Game.PlayerType.EasyComputerPlayer
  alias Game.PlayerType.HardComputerPlayer
  alias Communication.CommandLine.CommandLineFormatter

  describe "format_board/1" do
    test "converts the starting board into a CommandLine display friendly format" do
      board = %{
        1 => :empty, 2 => :empty, 3 => :empty,
        4 => :empty, 5 => :empty, 6 => :empty,
        7 => :empty, 8 => :empty, 9 => :empty
      }

      assert CommandLineFormatter.format_board(board) ===
      """

      1 | 2 | 3
      --|---|--
      4 | 5 | 6
      --|---|--
      7 | 8 | 9

      """
    end

    test "converts an ending board into a CommandLine display friendly format" do
      board = %{
        1 => "X", 2 => "O", 3 => "X",
        4 => "O", 5 => "X", 6 => "O",
        7 => "X", 8 => :empty, 9 => :empty
      }

      assert CommandLineFormatter.format_board(board) ===
      """

      X | O | X
      --|---|--
      O | X | O
      --|---|--
      X | 8 | 9

      """
    end
  end

  describe "format_player_setup/3" do
    test "returns the Player 1 prompt for the symbol X" do
      symbols = ["X", "O"]
      player_types = [
        %{type: HumanPlayer, name: "Human"},
        %{type: EasyComputerPlayer, name: "Computer"}
      ]

      assert CommandLineFormatter.format_player_setup("X", player_types, symbols) ==
      "Please select Player 1 (X) => 1 - Human, 2 - Computer: "
    end

    test "returns the Player 2 prompt for the symbol O" do
      symbols = ["X", "O"]
      player_types = [
        %{type: HumanPlayer, name: "Human"},
        %{type: EasyComputerPlayer, name: "Computer"}
      ]

      assert CommandLineFormatter.format_player_setup("O", player_types, symbols) ==
      "Please select Player 2 (O) => 1 - Human, 2 - Computer: "
    end
  end

  describe "format_computer_difficulty_setup/3" do
    test "returns the select difficulty prompt for the computer difficulty selection" do
      computer_difficulties = [
        %{type: EasyComputerPlayer, name: "Easy"},
        %{type: HardComputerPlayer, name: "Unbeatable"}
      ]

      assert CommandLineFormatter.format_computer_difficulty_setup(computer_difficulties) ==
      "Please select Difficulty => 1 - Easy, 2 - Unbeatable: "
    end
  end
end
