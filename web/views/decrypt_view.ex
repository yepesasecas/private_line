defmodule PrivateLine.V1.DecryptView do
  use PrivateLine.Web, :view

  def render("create.json", %{stone: stone}) do
    stone
  end

  def render("create.json", %{error_message: error_message}) do
    error_message
  end

  def render("400.json", _assigns) do
    "Bad Request"
  end
end
