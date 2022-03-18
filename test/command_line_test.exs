defmodule CommandLineTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "displays message" do
    message = "foo"
    assert capture_io(fn -> CommandLine.display(message) end) === message
  end

  test "reads message" do
    user_input_message = "1"
    assert capture_io(user_input_message, fn -> IO.write(CommandLine.read_input()) end) ===
      "Please input desired placement: #{user_input_message}"
  end
end
