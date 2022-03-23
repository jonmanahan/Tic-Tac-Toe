defmodule CommunicatorMock do
  @moduledoc """
  The module that mocks the Command Line display function,
  returning the message instead of displaying it to the Command Line
  """
  use GenServer

  @behaviour CommunicationBehaviour

  @impl true
  def display(message) do
    GenServer.call(CommunicatorMockServer, {:display, message})
  end

  @impl true
  def read_input() do
    GenServer.call(CommunicatorMockServer, :read_input)
  end

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, "", name: CommunicatorMockServer)
  end

  @impl true
  def init(full_message) do
    {:ok, full_message}
  end

  @impl true
  def handle_call({:display, message}, _from, full_message) do
    full_message = full_message <> message
    {:reply, full_message, full_message}
  end

  @impl true
  def handle_call(:read_input, _from, full_message) do
    user_input = "1"
    full_message = full_message <> "Please input desired placement: #{user_input}"
    {:reply, user_input, full_message}
  end
end
