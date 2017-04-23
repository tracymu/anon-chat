defmodule AnonChat.RoomChannel do
  use Phoenix.Channel
  alias AnonChat.ChatHistory

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> room_id, params, socket) do
    {:ok, assign(socket, :room_id, String.to_integer(room_id))}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_in("new_answer", %{"body" => body, "id" => id}, socket) do
    ChatHistory.add_message(%{body: body, id: id}) #could put room name in herei f wanted
    broadcast! socket, "new_answer", %{body: body, id: id}
    {:noreply, socket}
  end  

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end