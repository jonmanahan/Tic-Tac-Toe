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

  describe "read_input/0" do
    test "reads message" do
      user_input_message = "1"
      assert capture_io(user_input_message, fn -> IO.write(CommandLineCommunicator.read_input()) end) ===
        "Please input desired placement: #{user_input_message}"
    end
  end
end