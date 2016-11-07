defmodule PrivateLine.PageController do
  use PrivateLine.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
