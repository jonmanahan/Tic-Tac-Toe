defmodule CommunicatorMock do
  @moduledoc """
  The module that mocks the Command Line display function,
  returning the message instead of displaying it to the Command Line
  """
  use GenServer

  alias Communication.CommunicationBehaviour
  @behaviour CommunicationBehaviour

  @impl true
  def display(message) do
    GenServer.call(CommunicatorMockServer, {:display, message})
  end

  @impl true
  def read_input() do
    GenServer.call(CommunicatorMockServer, :read_input)
  end

  def start_link(user_inputs) do
    GenServer.start_link(__MODULE__, {"", user_inputs}, name: CommunicatorMockServer)
  end

  @impl true
  def init({full_message, user_inputs}) do
    Process.put(:mock_user_inputs, user_inputs)
    {:ok, full_message}
  end

  @impl true
  def handle_call({:display, message}, _from, full_message) do
    full_message = full_message <> message
    {:reply, full_message, full_message}
  end

  @impl true
  def handle_call(:read_input, _from, full_message) do
    [user_input | remaining_user_inputs] = Process.get(:mock_user_inputs)
    Process.put(:mock_user_inputs, remaining_user_inputs)
    full_message = full_message <> "please make desired move: #{user_input}"
    {:reply, user_input, full_message}
  end
end
