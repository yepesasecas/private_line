defmodule PrivateLine.V1.KeysView do
  use PrivateLine.Web, :view

  def render("index.json", %{keys: keys}) do
    keys
  end
end
