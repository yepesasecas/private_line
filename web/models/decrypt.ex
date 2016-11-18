defmodule PrivateLine.Decrypt do
  @private_key "-----BEGIN RSA PRIVATE KEY-----\n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\n-----END RSA PRIVATE KEY-----\n"

  def decrypt_and_merge(%{"stone" => stone} = params) when is_list(stone) do
    stone
    |> decrypt_stone_pieces
    |> concat_stone_pieces
    |> Poison.decode
    |> merge_stone_with_destination_format(params)
  end

  def decrypt_and_merge(%{"stone" => stone} = params) do
    stone
    |> decrypt_stone
    |> Poison.decode
    |> merge_stone_with_destination_format(params)
  end

  # private

  defp decrypt_stone_pieces(stone_list) when is_list(stone_list) do
    stone_list
    |> Enum.map(fn(x) -> decrypt_stone(x) end)
  end

  defp concat_stone_pieces(stone_list) do
    stone_list
    |> Enum.reduce(fn(stone_piece, decrypted_stone) -> decrypted_stone <> stone_piece end)
  end

  defp decrypt_stone(stone) do
    {:ok, decrypted_stone} = RsaEx.decrypt(stone, @private_key)
    decrypted_stone
  end

  defp merge_stone_with_destination_format({:error, _}, _) do
    :bad_stone
  end

  defp merge_stone_with_destination_format({:ok, decrypted_stone}, %{"destination_format" => destination_format, "destination_variables" => destination_variables}) do
    {error?, destination_response} = Enum.reduce(destination_variables, {false, destination_format}, fn(var, {error?, destination_format}) ->
      case Map.fetch(decrypted_stone, var) do
        {:ok, res} ->
          {error?, String.replace(destination_format, "{{{#{var}}}}", res)}
        :error ->
          {true, destination_format}
      end
    end)
    case error? do
      true -> :error
      false -> {:ok, destination_response}
    end
  end
end
