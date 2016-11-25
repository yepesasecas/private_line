defmodule PrivateLine.V1.DecryptStoneController do
  use PrivateLine.Web, :controller

  def create(conn, %{"stone" => encrypted_stone}) when is_list(encrypted_stone) do
    case PrivateLine.StoneDecrypt.decrypt(encrypted_stone) do
      {:ok, stone, _msg} ->
        conn
        |> render(stone: stone)
      {:error, _stone, msg} ->
        conn
        |> put_status(400)
        |> render(error_message: msg)
    end


  end

  def create(conn, _params) do
    conn
    |> put_status(400)
    |> render("400.json")
  end
end
