defmodule PrivateLine.V1.KeysController do
  use PrivateLine.Web, :controller

  def index(conn, _params) do
    private_key = PrivateLine.Keys.private_key
    public_key  = PrivateLine.Keys.public_key
    {:ok, encrypted_msg} = RsaEx.encrypt(Poison.encode!(%{billing_first_name: "Rommel", billing_last_name: "Samanez", billing_address1: "tu casa dir", billing_address2: "apto123", billing_city: "Lima"}), public_key)
    response = %{public_key: public_key,
                private_key: private_key,
                encrypted_msg: encrypted_msg }

    render conn, %{response: response}
  end

  def create(conn, params) do
    %{"destination_url" => destination_url, "destination_headers" => destination_headers} = params
    case PrivateLine.Decrypt.decrypt_and_merge(params) do
      {:ok, res} ->
        case PrivateLine.MyHttp.post(destination_url, res, destination_headers) do
          {:ok, res} ->
            conn
            |> render(%{response: res})
          {:error, error} ->
            conn
            |> put_status(400)
            |> render(%{response: error})
        end
      :error ->
        conn
        |> put_status(400)
        |> render(%{response: %{error: "400 Bad Request."}})
      :bad_stone ->
        conn
        |> put_status(400)
        |> render(%{response: %{error: "400 Bad Stone Request."}})
    end
  end
end
