defmodule PrivateLine.CsmController do
  use PrivateLine.Web, :controller

  plug :put_layout, "no_layout.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end
