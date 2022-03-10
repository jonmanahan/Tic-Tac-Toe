defmodule TicTacToeTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "displays the welcome message" do
    assert capture_io(fn -> TicTacToe.welcome_message() end) === "Welcome to Tic-Tac-Toe"
  end
end
