defmodule CommandLineCommunicatorTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Communication.CommandLine.CommandLineCommunicator

  describe "display/1" do
    test "displays message" do
      message = "foo"
      assert capture_io(fn -> CommandLineCommunicator.display(message) end) === message
    end
  end

  describe "read_input/1" do
    test "displays prompt and reads message" do
      user_input_message = "1"
      assert capture_io(user_input_message, fn -> IO.write(CommandLineCommunicator.read_input("please make desired move: ")) end) ===
        "please make desired move: #{user_input_message}"
    end
  end
end
