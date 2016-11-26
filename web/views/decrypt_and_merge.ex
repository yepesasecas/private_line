defmodule PrivateLine.V1.DecryptAndMergeView do
  use PrivateLine.Web, :view

  def render("create.json", %{response: {:error, _stone, _destination_format, _destination_variables, msg}}) do
    msg
  end

  def render("create.json", %{response: {:ok, stone, destination_format, _destination_variables, _msg}}) do
    %{stone: stone, destination_format: destination_format}
  end
  
  def render("400.json", _assigns) do
    "Bad Request"
  end
end
