defmodule CommandLineTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "(unit test) displays message" do
    message = "foo"
    assert capture_io(fn -> CommandLine.display(message) end) === message
  end
end
