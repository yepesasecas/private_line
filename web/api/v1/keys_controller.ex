defmodule PrivateLine.V1.KeysController do
  use PrivateLine.Web, :controller

  def index(conn, _params) do
    private_key_jwk = JOSE.JWK.from_pem_file("rsa-2048.pem")
    public_key_jwk = JOSE.JWK.to_public(private_key_jwk)
    {_, {_, public_key, _}} = public_key_jwk.kty
    IO.inspect public_key_jwk
    render conn, %{keys: %{public_key: public_key}}
  end
end
