defmodule PrivateLine.V1.DecryptStoneController do
  use PrivateLine.Web, :controller

  def create(conn, %{"stone" => encrypted_stone}) when is_list(encrypted_stone) do
    conn
    |> render(stone: PrivateLine.StoneDecrypt.decrypt(encrypted_stone))
  end

  def create(conn, %{"stone" => encrypted_stone}) do
    conn
    |> render(stone: PrivateLine.StoneDecrypt.decrypt(encrypted_stone))
  end

  def create(conn, _params) do
    conn
    |> put_status(400)
    |> render("400.json")
  end
end
