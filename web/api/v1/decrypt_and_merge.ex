defmodule PrivateLine.V1.DecryptAndMergeController do
  use PrivateLine.Web, :controller

  alias PrivateLine.StoneDecrypt
  alias PrivateLine.StoneMerger

  def create(conn, %{"stone" => stone, "destination_format" => destination_format,
                    "destination_variables" => destination_variables}) do
    {status, stone, msg} = StoneDecrypt.decrypt(stone)
    response = StoneMerger.merge({status, stone, destination_format, destination_variables, msg})

    case response do
      {:error, _stone, _destination_format, _destination_variables, _msg} ->
        conn
        |> put_status(400)
        |> render("create.json", response: response)
      _ ->
        conn
        |> render("create.json", response: response)
    end
  end

  def create(conn, _params) do
    conn
    |> put_status(400)
    |> render("400.json")
  end
end
