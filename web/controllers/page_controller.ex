defmodule AnonChat.PageController do
  use AnonChat.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
