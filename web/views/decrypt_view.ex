defmodule PrivateLine.V1.DecryptView do
  use PrivateLine.Web, :view

  def render("400.json", _assigns), do: %{error: "Bad Request"}
  def render("create.json", %{error_message: error_message}), do: %{error: error_message}
  def render("create.json", %{stone: stone}) do
    %{stone: stone}
  end
end
