defmodule PrivateLine.V1.KeysController do
  use PrivateLine.Web, :controller

  def index(conn, _params) do
    private_key = "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEArhPHlBcTCeVckL4cn/khF6o/Rpik1oA68L2j1zFhxTlkMa0P\nr/zl0+V5CqreuJ6RHd4d6kZGUv9pCt4Wz5ZKhIIpRjwPM5Sap3eTOMUoOWeZYF5q\ngZQ/hTkskVoFIv4AAl4Bx1DkdfUY7zcB3Tjt1cXzJMdom6AxP/i/t6/wbk2/tQ1i\nFqLbbpEI+E4d+jxKrvWBg5dAtEmco6IlLUDocAs95A6hEaFGb8X8XV9a6yPlqQnQ\n/x312oYw7PCiMm+4TjTIogYXJMAhUwUNOjks3X4aw6EoyxzKCyi/TRK52Iugq++4\nrneUOpFtSPs0YeJvY8sda6RGxsmzcytBvc8o6wIDAQABAoIBACvJc+lPSI2zsO4D\ntCWVP/q460Oxv7zo8mp9+Ul29XXrssVAF/MXtSPw09qYEn/z+uK9bV7xoFzePCjs\npmY/Eq10JDezgctitOgtDs434Z9W7OCtvzKq/LNhJ1HEiAg+RfhSdzYQpfb52PTL\nLF/eIw0jxr5YnnqO9/R0eJ0W126XG6RNbE6YfA0azfuKC35PQKlI8X8OehkmAasA\nTPvhrRPFM/pD3OS0PLxKvS8aXNLV/SNI6kqg9dB1SVMbJfSQ72fqH6CLKZoM23Ip\nhparhYd+IF7qJcYbygfG0sNgG+ou9gNc7rmcWpCVC3lv5nL5NhxdQlW+DsTuUy7+\n0lkeWYkCgYEA303qKjxVIWynn2oy+avcSY29h1/fBngqUUpKzNw+RVlNKYk2VD1O\nfINSDybLZIFQCxMxxa97+a+juwKvV9I8G80Fs5Z3oReXcZs0mCZ/J3dDEexOMjT3\n8ZdiIm4bv19ryLiUve0AROmDOcztDN+2Oy6pAMAPY/9m7KIWfAVo8X0CgYEAx5Cx\nYREv8mqI4YtfWIqGGSExmRTjvPNVvighIe4cExwsY0hqBjl6oUp1rI1A/aWeP0nT\ny7XTs+80PblcjxjklVUah1COaYwKnTD5XYQgM1moQQZ+czR0wclIQh1k97xGXl3v\nAM2/nIN8LbNBit3g1s47Bo55QFfGiO1389PgEIcCgYAWvKc4L7Z3VcnniHeyRlaC\nwsTmkNNzpC6i4k6ld1N72jDqJsd6Yleog/KKCmgxTp1o00aBG3IjJUgllYtnBMgM\nCJ8o/wwlQfKwpZ4AVAMkcJdKruXzZMNOPRzH5rA6lyuxX2H9yLD7U0+CRiRo6Cp0\n8jZRFj068Fl5hLOHY0GhPQKBgA53l9RQmag6PugS4XuatzP1KxJM6GGXRlz9rcE2\n8MQV48XixwTif9hXfIZgyxhYPEucP4ViDhHaQnBDEsmw5UlKHR04IsrWAyL4HOvB\nm0/9rOvh26LgZ6JwxBM+7EXlWTiYGK53O+/NvF/XweWeRiFsW+0SwQmAE31zsaF0\nd6bbAoGAeODAQgwxJ/btRj5Pmo9dn6ounjntSTD/+jw84BHXv5EkgMyi7ePZwiCw\n9FxuZOXEMDYPsikNqP7qX4C7lPg8NOMX5egFQxV10zdPDSSqnLu8oWkqvMzK2oKb\nc3d8nDLAqEGaq0+oSBESDMZGoOiUS09Q8yEz2SI6t/uN9nP9Y9M=\n-----END RSA PRIVATE KEY-----\n"
    public_key  = "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArhPHlBcTCeVckL4cn/kh\nF6o/Rpik1oA68L2j1zFhxTlkMa0Pr/zl0+V5CqreuJ6RHd4d6kZGUv9pCt4Wz5ZK\nhIIpRjwPM5Sap3eTOMUoOWeZYF5qgZQ/hTkskVoFIv4AAl4Bx1DkdfUY7zcB3Tjt\n1cXzJMdom6AxP/i/t6/wbk2/tQ1iFqLbbpEI+E4d+jxKrvWBg5dAtEmco6IlLUDo\ncAs95A6hEaFGb8X8XV9a6yPlqQnQ/x312oYw7PCiMm+4TjTIogYXJMAhUwUNOjks\n3X4aw6EoyxzKCyi/TRK52Iugq++4rneUOpFtSPs0YeJvY8sda6RGxsmzcytBvc8o\n6wIDAQAB\n-----END PUBLIC KEY-----\n"
    {:ok, encrypted_msg} = RsaEx.encrypt(Poison.encode!(%{billing_first_name: "Rommel", billing_last_name: "Samanez", billing_address1: "tu casa dir", billing_address2: "apto123", billing_city: "Lima"}), public_key)
    response = %{public_key: public_key,
                private_key: private_key,
                encrypted_msg: encrypted_msg }

    render conn, %{response: response}
  end

  def create(conn, params) do
    %{"destination_url" => destination_url, "destination_headers" => destination_headers} = params
    case PrivateLine.Decrypt.decrypt(params) do
      {:ok, res} ->
        case PrivateLine.MyHttp.post(destination_url, res, destination_headers) do
          # TODO mejorar PrivateLine.MyHttp.post() para parsear la respuesta de HTTPoison
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
        |> render %{response: %{error: "400 Bad Request."}}
    end
  end
end
