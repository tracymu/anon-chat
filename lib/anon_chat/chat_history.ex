defmodule AnonChat.ChatHistory do
  @name :chat_history

  @initial_state %{
    chat_history: []
  }
  # the purpose of this module is to get an agent to start a process which will hold the state that I want
  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, @name)
    Agent.start_link(fn -> @initial_state end, opts)
  end

  def add_message(message, name \\ @name) do
    Agent.update name, fn state ->
      new_history = [message | state.chat_history]
      %{ state | chat_history: new_history }      
    end
  end

  def load_messages(name \\ @name) do
    Agent.get name, fn state ->
      state
    end
  end
end
