defmodule CommunicatorMock do
  @moduledoc """
  The module that mocks the Command Line display function,
  returning the message instead of displaying it to the Command Line
  """
  use Agent

  @behaviour CommunicationBehaviour

  def display(message) do
    start_mock_agent()
    Agent.update(CommunicatorMockAgent, &(&1 <> message <> "\n"))
    Agent.get(CommunicatorMockAgent, & &1)
  end

  def read_input() do
    start_mock_agent()
    user_input = "1"
    Agent.update(CommunicatorMockAgent, &(&1 <>
      "Please input desired placement: #{user_input}"))
    Agent.get(CommunicatorMockAgent, & &1)
  end

  defp start_mock_agent do
    if !Process.whereis(CommunicatorMockAgent) do
      Agent.start_link(fn -> "" end, name: CommunicatorMockAgent)
    end
  end
end
