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
    GenServer.call(__MODULE__, {:display, message})
  end

  @impl true
  def read_input(prompt) do
    GenServer.call(__MODULE__, {:read_input, prompt})
  end

  def start_link(user_inputs) do
    GenServer.start_link(__MODULE__, {"", user_inputs}, name: __MODULE__)
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
  def handle_call({:read_input, prompt}, _from, full_message) do
    [user_input | remaining_user_inputs] = Process.get(:mock_user_inputs)
    Process.put(:mock_user_inputs, remaining_user_inputs)
    full_message = full_message <> prompt <> "#{user_input}"
    {:reply, user_input, full_message}
  end
end
