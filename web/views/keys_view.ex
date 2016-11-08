defmodule PrivateLine.V1.KeysView do
  use PrivateLine.Web, :view

  def render("index.json", %{response: response}) do
    response
  end
end
