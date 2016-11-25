defmodule PrivateLine.V1.DecryptStoneView do
  use PrivateLine.Web, :view

  def render("create.json", %{stone: stone}) do
    stone
  end

  def render("400.json", _assigns) do
    "Bad Request"
  end
end
