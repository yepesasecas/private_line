defmodule PrivateLine.MyHttp do

  def post(url, body, headers) do
    case HTTPoison.post(url, body, Map.to_list(headers)) do
      {:ok, %HTTPoison.Response{body: body, status_code: status_code}} ->
        {:ok, %{body: body, status_code: status_code}}
      {:error, error} ->
        {:error, error}
    end
  end
end
