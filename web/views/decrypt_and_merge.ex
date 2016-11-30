defmodule PrivateLine.V1.DecryptAndMergeView do
  use PrivateLine.Web, :view

  def render("400.json", _assigns), do: %{error: "Bad Request"}
  def render("create.json", %{response: {:error, _stone, _destination_format, _destination_variables, msg}}), do: %{error: msg}
  def render("create.json", %{response: {:ok, stone, destination_format, _destination_variables, _msg}}) do
    %{stone: stone, destination_format: destination_format}
  end
end
