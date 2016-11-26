defmodule PrivateLine.V1.KeysController do
  use PrivateLine.Web, :controller

  alias PrivateLine.Keys

  def index(conn, _params) do
    private_key = Keys.private_key
    public_key  = Keys.public_key
    {:ok, encrypted_msg} = RsaEx.encrypt(Poison.encode!(%{billing_first_name: "Rommel", billing_last_name: "Samanez", billing_address1: "tu casa dir", billing_address2: "apto123", billing_city: "Lima"}), public_key)
    response = %{public_key: public_key,
                private_key: private_key,
                encrypted_msg: encrypted_msg }

    render conn, %{response: response}
  end
end
